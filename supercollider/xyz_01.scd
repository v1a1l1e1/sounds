(
SynthDef(\hey,{|out=0, freq=100, phase=0|
	var sig;
	var f = {Dust.kr(freq).exprange(10, 50)}!2;
	sig = Impulse.ar(f, phase, 0.1);
	Out.ar(out, sig);
}).add;
)

20.do({Synth(\hey,[\freq, rrand(10, 20), \phase, (0..2).choose*pi])});

/* --- */
(
~src = Group.new;
~dly = Group.after(~src);
~rev = Group.after(~dly);
~fx1_bus = Bus.audio(s, 2);
~fx2_bus = Bus.audio(s, 2);

SynthDef(\xyz_01, {|out=0, freq = 220, width=0.5|
	var sig, env;
	sig = Pulse.ar(freq!2, width);
	env = EnvGen.kr(Env.linen(0.5, 0.1, 1, 0.2, \sine), doneAction:2);
	sig = BPF.ar(sig, freq, 1/(freq*3/2));
	sig = sig * env * 0.2;
	Out.ar(out, sig);
}).add;

SynthDef(\dly, {
	var sig;
	sig = In.ar(~fx1_bus, 2);
	sig = CombN.ar(sig, 0.5, 0.3, 0.5);
	Out.ar(~fx2_bus, sig);
}).add;

SynthDef(\rev, {|freq=100|
	var sig;
	sig = In.ar(~fx2_bus, 2);
	//sig = BPF.ar(sig, freq, 1/freq);
	sig = FreeVerb.ar(sig, 1, 0.5);
	Out.ar(0, sig);
}).add;
)

(
~x = Pbind(
	\instrument, \xyz_01,
	\out, ~fx1_bus,
	\scale, Scale.minor.degrees,
	\dur, Pshuf([0.5, 0.1, 0.7], inf),
	\ctranspose, Prand([-1, 0, 1, 2, -2],inf),
	\mtranspose, Pshuf([0, 1, 2, -1, -2, 0], inf),
	\degree,Prand([0, 2, 4, 5, 7, 9, 11], inf),
	\group, ~src,
).play;
)

(
y = Synth(\dly, target:~dly);
z = Synth(\rev, [\freq, 100], ~rev);
)

~x.stop;
y.free;
z.free;

Scale.directory;

s.meter;
s.plotTree;
s.quit;
s.freeAll;