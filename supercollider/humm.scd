(
SynthDef(\static, {|freq=1 amp=0.5|
	var sig = SinOsc.ar(Dust.ar(rrand(freq/2, freq*2)!2).range(60, 70), mul:0.5);
	sig = Pan2.ar(sig, SinOsc.kr(0.5).range((-0.7), 0.7));
	Out.ar(0, sig*amp);
}).add;

SynthDef(\sparks, {|on=0|
	var sig = Crackle.ar(1.99, Dust.kr([2, 2.1]));
	Out.ar(0, sig*on);
}).add;
)

(
~humm = Pbind(
	\instrument, \static,
	\dur, Pseq([1],1),
	\freq, Prand([0.5, 1, 1,5, 2],1),
).play;

~sparks = Pbind(
	\instrument, \sparks,
	\dur, Prand([0.5, 1, 1.5],inf),
	\on, Pwrand([1, 0], [0.8, 0.2], inf),
).play;
)

s.plotTree;