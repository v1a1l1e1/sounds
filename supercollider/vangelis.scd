(
SynthDef(\iteration, {|freq=40|
	var sig, tmp, env;
	sig=0;
	10.do{
		tmp = VarSaw.ar(freq* {Rand(0.99, 1.02)}!2, {Rand(0.0, 1,0)}!2, {ExpRand(0.05, 0.5)}!2);
		sig = sig+tmp
	};
	env = EnvGen.kr(Env.perc(0.01, 5, 1, -2), doneAction:2);
	sig = sig *  0.05 * env;
	Out.ar(0, sig)
}).add;

SynthDef(\sum, {|freq=100, amp=0.1|
	var sig=0, tmp;
	10.do{
		arg cnt;
		tmp = SinOsc.ar(freq * (cnt+1) * LFNoise1.kr({Rand(0.05, 0.2)}!2).range(0.98, 1.02));
		tmp = tmp * EnvGen.kr(Env.perc(0.1, 0.7, LFNoise1.kr({Rand(0.5, 8)}!2).exprange(0.01, 1)), doneAction:2);
		sig = sig + tmp;
	};
	Out.ar(0, sig*amp);
}).add;
)

c = Synth(\sum);

(
var a, b;
a = Pbind(
	\instrument, \iteration,
	\dur, Pbjorklund(3,8, inf)/2,
	\freq, Prand([1, 2, 3, 4, 5, 6], inf)*40,
);

b = Pbind(
	\instrument, \sum,
	\dur, Pbjorklund(3,8, inf)/2,
	\freq, Prand([1, 2, 3, 4, 5, 6], inf)*40,
);
Ppar([a, b]).play;
)

s.plotTree;

