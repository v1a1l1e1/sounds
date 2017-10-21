(
p = ProxySpace.push(s);
p.makeTempoClock;
p.clock.tempo = 2;

s.waitForBoot({
	s.sync;
	d = Dictionary.new;

	PathName(PathName(thisProcess.nowExecutingPath).parentPath +/+"808").entries.do{|subfolder|
			d.add( subfolder.folderName.asSymbol -> Array.fill(
				subfolder.entries.size,{|i|
					Buffer.read(s, subfolder.entries[i].fullPath);}
			));
		};

	SynthDef(\player,{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, atk=0.01, rel=1, pos=0;
		var sig, env;
		sig = Pan2.ar(PlayBuf.ar(1,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(0.0,rel,0.0,1));
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
	}).add;

	StageLimiter.activate;
	"All done!".postln;

});

)

d.keys;

(
p.clock.tempo = (110/60);
~t = Pbind(\instrument, \player,\buf, d[\bd_][4],\amp, 1.1, \dur, Pbjorklund(Prand([5,3,7],inf),Pseq([8, 12], inf), inf));
~t.play;
~t2 = Pbind(\instrument, \player, \buf, d[\bd_][5], \amp, 0.9, \rel, 0.8, \pan , Pwhite(-1, 1));
~t2.play;
)

(
~s = Pbind(\instrument, \player, \buf,d[\sd_][1], \amp, 0.05, \rate, Pseq([1], inf), \dur, Pbjorklund(Pxrand([4,6,8],inf), 8, inf, 1)/2);
~s.play;
)

~t.stop;
~t2.stop;
~s.stop;
s.quit;