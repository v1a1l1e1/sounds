(
SynthDef(\markov, {|freq=220|
	var sig, env;
	sig = SinOsc.ar(freq,mul:0.7);
	env = EnvGen.kr(Env.perc(0.02,2), doneAction:2);
	Out.ar(0, sig*env);
}).add;

m=MarkovSet([
	[100, [120, 130]],
	[120, [100, 1900]],
	[130, 120],
]);

)

(
Pbind(
	\instrument, \markov,
	\dur, Pseq([0.5,1],inf),
	\freq, Pfunc({m.next(120)}),
).play;
)
