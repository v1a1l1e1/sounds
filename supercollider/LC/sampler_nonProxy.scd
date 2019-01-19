~buf1 = Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav");

~buf2 = Buffer.read(s,"/home/v1a1l1e1/Documenti/scripts/livecoding/SuperCollider_projects/LC/samples_SC/g/inv.wav");

~buf1.free;~buf2.free;

(
SynthDef(\g_play, {
	|out=0, buf, rate=1,int=1, amp=1, start=0, end=1, reset=0, d=1, trig=0|
	var sample, env;
	sample = BufRd.ar(1, buf,Phasor.ar(trig,BufRateScale.ir(buf)*rate, start,BufFrames.kr(buf)*end,BufFrames.kr(buf)*reset),0,int);
	env = EnvGen.kr(Env.linen(0.001,BufDur.kr(buf)*d,0.001),doneAction:2);
	Out.ar(out, Pan2.ar(sample*env,0,amp));
}).add;

SynthDef(\gplay,
	{
		|out=0, buf=0, rate=1, d=15, trig=1, pos=0, amp=0.5, pan=0|
		var sig,env;
		sig = PlayBuf.ar(2,buf,BufRateScale.ir(buf) * rate,trig,BufDur.kr(buf)*pos*s.sampleRate,doneAction:2);
		env = EnvGen.ar(Env.linen(0.0,d,0),doneAction:2);
		sig = sig * env;
		Out.ar(out,Pan2.ar(sig*amp,pan));
}).add;
)

(
x = Pbind (\instrument, \gplay, \buf, ~buf2,\rate, Pwhite(-3.2,3), \dur, 0.125, \pos, Pwhite(0, 1),\d, Pwhite(0.3, 1), \trig, Pbjorklund2(3,8)/4, \amp, 1);
x.play;

y = Pbind (\instrument, \g_play, \buf, ~buf1,\rate, Pwhite(-3.2,3), \dur, Pwhite(0.125, 1), \start, Pwhite(0, 2), \end, Pwhite(0.3, 1), \reset, Pwhite(0, 0.75), \d, Pwhite(0.3, 1), \trig, Pbjorklund2(3,8)/4);
y.play;
)

