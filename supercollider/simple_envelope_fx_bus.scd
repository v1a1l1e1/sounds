(
s.meter;
s.plotTree;
)

(
x = SynthDef(\envelope, {
	arg freq=12, fund = 300, out;
	var sig, env, trigger;
	trigger = Dust.kr(2);
	env = EnvGen.ar(
	Env.new(
		[0.01, 0.5, 0.9, 0.3, 0.01],
		[1, 0.6, 1,4, 1],
		\sine),
	trigger,
	doneAction: 2);
	sig = VarSaw.ar(LFPulse.kr(freq).exprange(fund, fund*4).round(fund));
	sig = sig * env*0.25;
	Out.ar(out,sig!2);
}).add;
)

(
g = SynthDef(\rev, {
	arg in, out=0;
	var sig;
	sig = In.ar(in, 1);
	sig = FreeVerb.ar(sig, 0.6)!2;
	Out.ar(out, sig);
}).add;
)

(
~src = Group.new;
~fx = Group.after(~src);
)
~rev_bus = Bus.audio(s,1);
~rev_bus.index;

y = Synth.new(\envelope, [\out, ~rev_bus, \freq, 8, \fund, 370], ~src);
w = Synth.new(\rev, [\in, ~rev_bus], ~fx);
y.free;
s.freeAll;

s.quit;
