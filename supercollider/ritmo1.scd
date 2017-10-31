(
s = Server.local;
p = ProxySpace.new(s, "live");
p.push;
p.makeTempoClock;
p.clock.tempo = 2;

u = PathName(thisProcess.nowExecutingPath).parentPath +/+"808";

ServerBoot.add({if(currentEnvironment === p, {"ProxySpace running"}, {"ProxySpace not running"})});

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

DDWSnippets.put("kick", "~k = Pbind(\\instrument,\\player,\\buf,d[\\bd_][4],\\dur,##1##,\\amp, 1.5,);");

~k = Pbind(\instrument,\player,\buf,d[\bd_][4],\dur,1,\amp, 1.5,);
~k.play;



(
p.clock.tempo = (114/60) ;
~k1 = Pbind(\instrument, \player,\buf, d[\bd_][4],\amp, 1.5, \dur, 1);
~k1.play;
~k2 = Pbind(\instrument, \player,\buf, d[\bd_][3],\amp, 0.8, \dur, Pwrand([0.75, Pbjorklund(12, 16, 5,1)], [0.1, 0.9], inf));
~k2.play;
~sn = Pbind(\instrument, \player, \buf,d[\sd_][0], \dur, Pwrand([0.75,0.5], [0.65, 0.45], inf));
~sn.play;
)


~k1.stop;
~k2.stop;
~sn.stop;

p.clear;
p.pop;
p.clear;
currentEnvironment.clear;
s.quit;