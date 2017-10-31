(
SynthDef(\wah, {|freq=200, iphase=0, width=0.5, out=0, amp=1, pan_f=1|
	var sig;
	sig = VarSaw.ar(freq!2, iphase, width);
	sig = sig * EnvGen.kr(Env([0, 1, 1, 0], [1, 1, 3]), doneAction:2);
	Out.ar(out, Pan2.ar(sig*amp, SinOsc.kr(pan_f)));
}).add;
)

(
Pbind(
	\instrument, \wah,
	\dur, 2,
	\iphase, Prand((0..2),inf)*pi,
	\freq, Pxrand((50..60), inf),
	\pan_f, (0.1, 0.15..7).choose,
).play;
)
s.meter