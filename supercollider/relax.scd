(
SynthDef(\k, {|gate=1,freq=100, rq=0.5, amp=1, atk=1, rel=2|
	var sig = WhiteNoise.ar(SinOsc.kr(0.1)!2);
	sig = Resonz.ar(sig, freq, rq, amp);
	Out.ar(0, sig*Linen.kr(gate, atk, releaseTime:rel, doneAction:2));
}).add;

SynthDef(\wah, {|freq=200, iphase=0, width=0.5, out=0, amp=1, pan_f=1|
	var sig;
	sig = VarSaw.ar(freq!2, iphase, width);
	sig = sig * EnvGen.kr(Env([0, 1, 1, 0], [1, 1, 3]), doneAction:2);
	Out.ar(out, Pan2.ar(sig*amp, SinOsc.kr(pan_f)));
}).add;
)

(
~e = Pbind(
	\instrument, \wah,
	\dur, 2,
	\iphase, Prand((0..2),inf)*pi,
	\freq, Pxrand((50..60), inf),
	\pan_f, (0.1, 0.15..7).choose,
	\amp, 0.1,
);

~f = Pbind(
	\instrument, \k,
	\dur, 0.5,
	\freq, Pxrand([
		Pxrand((50, 55..400),4),
		Pxrand((75, 90..600), 6),
		Pseq([[230, 510, 240],[64,89,102]],8)
	],inf),
	\rq, rrand(0.001, 0.007),
	\amp, 4,
);
~g = Pbind(
	\instrument, \k,
	\dur, 1,
	\freq, Pxrand([
		Pxrand((150, 155..600),4),
		Pxrand((175, 190..2000), 6),
		Pseq([[230, 510, 240],[64,89,102]],8)
	],inf),
	\rq, rrand(0.0001, 0.006),
	\amp, 1,
);
)

~h = Ppar([~f, ~g, ~e],inf);
~h.play;
~h.stop;

s.plotTree;