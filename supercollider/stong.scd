// CombN.ar(in, maxdelaytime, delaytime, decaytime, mul, add) //

{CombN.ar(Decay.ar({Dust.ar(0.5, 0.5)}.dup , 0.5, SinOsc.ar), 1.5, 1, 3)}.scope(2, zoom:1);
{CombN.ar(WhiteNoise.ar(0.02), 0.01, XLine.kr(0.0001, 0.01, 20), 0.2)}.scope(2, zoom:4);

(
SynthDef(\stong,{|atk=0.001, sus=1.5, rel=1|
	var sig, env;
	env = EnvGen.kr(Env.linen(atk, sus, rel), doneAction:2);
	sig = CombN.ar(
		Decay.ar(
			{Dust.ar(0.2, 0.5)}!2,
			0.5,
			SinOsc.ar),
		1.5,
		1,
		3);
	Out.ar(0, sig*env);
}).add;
)

(
Pbind(
	\instrument, \stong,
	\dur, 2,
).play;
)