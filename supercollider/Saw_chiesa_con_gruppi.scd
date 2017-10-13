s.meter;
s.plotTree;

(
~src = Group.new;
~fx = Group.after(~src);
~fx_bus = Bus.audio(s, 2);
)

(
SynthDef(\pad, {|freq=100, out=0, amp = 0.5, atk=0.5, decay = 0.5, rel = 3|
	var sig, env;
	sig = {Saw.ar(freq)}!2;
	env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [atk, decay, rel], [2, 1, -1]),doneAction:2);
	sig = sig*env*amp;
	Out.ar(out, sig);
}).add;
);
(
SynthDef(\rev, {|out=0, amp=0.5|
	var sig;
	sig = In.ar(~fx_bus,2);
	sig = FreeVerb.ar(sig, 1, 0.5);
	sig = AllpassN.ar(sig, 0.01, 0.01,0.5);
	Out.ar(out, sig);
}).add;
);

(
~pattern = Pbind(
	\instrument, \pad,
	\out, ~fx_bus,
	\freq, Prand((Scale.major.degrees+64).midicps,inf)*rrand(0.25, 2),
	\atk, 1,
	\decay, 0.5,
	\rel, Pseq([rrand(1.3, 2)], inf),
	\group, ~src,
	\dur, Pseq([rrand(1, 0.7)], inf),
).play;
)

y = Synth(\rev,[\amp, 1], target: ~fx);

~pattern.stop;
y.free;

s.freeAll;
s.quit;