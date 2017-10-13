s.meter;
s.plotTree;

(
x = SynthDef(\envelope, {
	arg t_trigger = 1, freq=12, fund = 300;
	var sig, env;
	env = EnvGen.ar(
	Env.new(
		[0.01, 0.5, 0.9, 0.3, 0.01],
		[1, 0.6, 1,4, 1],
		\sine),
	t_trigger,
	doneAction: 2);
	sig = VarSaw.ar(LFPulse.kr(freq).exprange(fund, fund*4).round(fund));
	sig = sig * env*0.25;
	Out.ar(0,sig!2);
}).add;
)

y = Synth.new(\envelope, [\freq, 8, \fund, 370]);
y.free;
s.freeAll;
