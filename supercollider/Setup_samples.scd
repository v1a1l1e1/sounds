(
s = Server.local;

// extra safe
s.newBusAllocators;

s.options.sampleRate_(44100);
s.options.memSize_(2.pow(20)); //realtime memory size (~ 1GB)

p = ProxySpace.new(s, "live");
p.push;
p.makeTempoClock;
p.clock.tempo = 2;

u = PathName(thisProcess.nowExecutingPath).parentPath +/+"808";
r = {"Cleaning ... ".post; p.clear; p.pop; currentEnvironment.clear; "cleanup done".postln};

ServerBoot.add({if(currentEnvironment === p, {"ProxySpace running".postln}, {"ProxySpace not running".postln})});
ServerQuit.add(r);

s.waitForBoot({

	s.sync;
	d = Dictionary.new;

	PathName(u).entries.do{|subfolder|
			d.add( subfolder.folderName.asSymbol -> Array.fill(
				subfolder.entries.size,{|i|
					Buffer.read(s, subfolder.entries[i].fullPath);}
			));
		};

	SynthDef(\player,{|out=0, buf=0, rate=1, amp=0.5, pan=0, atk=0.01, rel=1, pos=0|
		var sig, env;
		sig = Pan2.ar(PlayBuf.ar(1,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(0.0,rel,0.0,1));
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
	}).add;

	StageLimiter.activate;
	"All done!".postln;
	"===> ARGS: out buf rate amp pan atk rel pos".postln;

});
)