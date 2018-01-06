(
SynthDef(\dly, {|density=1, vol=0.5, dcy_t=0.8, freq=100, max_dly_t=0.5, max_dly=0.2, dcy=0.5|
	var sig, env;
	sig = CombN.ar(Decay.ar(Dust.ar(density, vol),dcy_t, SinOsc.ar(freq!2)), max_dly_t, max_dly, dcy);
	env = EnvGen.kr(Env.linen(sustainTime:3, releaseTime:2), doneAction:2);
	Out.ar(0, sig*env);
}).add
)

(
Pbind(
	\instrument, \dly,
	\dur, Pbjorklund(5,8,inf),
	\density, Pseq([1, 0.5, 1.5, 0.7, 1.2, 1, 0.5],inf),
	\dcy_t, Prand([0.8, 0.5, 1],inf),
	\freq, Prand([100, 120, 200, 400, 350],inf),
	\max_dly_t, 0.5,
	\max_dly, Prand([0.1, 0.2, 0.3, 0.4, 0.5],inf),
	\dcy, Pseq([0.5, 0.4, 0.3, 0.2, 0.1],inf)
).play;
)
s.meter;
s.plotTree;

