(
SynthDef(\tone,{
	var sig, env;
	sig = SinOsc.ar(LFNoise1.kr(VarSaw.kr(5!2, rand(0, 0.5), ExpRand(0.1, 0.8))).exprange(60, 600));

	env = EnvGen.kr(Env.linen(1, 0.9, 2, curve:'sine'), doneAction:2);
	Out.ar(0, sig*env*0.1);
}).add
)

(
s.scope.style=2;
s.scope.yZoom=5;
)

(
Pbind(
	\instrument, \tone,
	\dur, 2,
).play;
)