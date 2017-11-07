(
SynthDef(\res,{
	|out=0, freq=1, f_min=50, f_max=660, amp=0.7, fc=150, bwr=0.5|
	var sig, env;
	sig = SinOsc.ar(LFSaw.kr([freq, freq+rrand(0.5, 1.1)]).range(f_min, f_max));
	env = EnvGen.kr(Env([0,1,1,0], [0.1, 0.5, 0.5]), doneAction:2);
	sig = sig * env;
	sig = Resonz.ar(sig, fc, bwr);
	Out.ar(out, sig*amp);
}).add
)

s.meter;

(
~pat = Pbind(
	\instrument, \res,
	\dur,Prand([0.1, 0.3, 0.5],inf),
	\freq, Pxrand([0.5, 1, 1.5, 2, 2.5],inf),
	\f_min, Pxrand((20..60), inf),
	\f_max, Pkey(\f_min)+Pxrand((200..400),inf),
	\fc, Pseq([100, 150, 200, 250, 300].pyramid, inf),
	\bwr, 0.01
).play;
)

~pat.play;
~pat.stop;