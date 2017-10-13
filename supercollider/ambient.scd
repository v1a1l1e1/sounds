(
SynthDef(\smooth,{|f_pul=100, f_blip=10, n_harm=50|
	var out, sig, env;
	sig = Blip.ar(
		(SinOsc.kr(f_blip).range(0, f_blip/2*3))!2,
		n_harm,
		Dust2.kr(f_pul!2).range(0,1),
		0.5
	);
	env = EnvGen.kr(Env.new([0, 0.5, 1, 0.5, 0], [1, 2, 4, 2, 1], \sine), doneAction:2);
	out = sig * env;
	out = FreeVerb.ar(out, 0.4, 0.7, XLine.kr(0.1, 0.7, 2));
	Out.ar(0, out);
}).add;
)

(
SynthDef(\smooth_no_pattern,{|f_pul=100, f_blip=10, n_harm=50|
	var out, sig;
	sig = Blip.ar(
		(SinOsc.kr(f_blip).range(0, f_blip/2*3))!2,
		n_harm,
		Dust2.kr(f_pul!2).range(0,1),
		0.5
	);
	out = FreeVerb.ar(sig, 0.4, 0.7, XLine.kr(0.1, 0.7, 2));
	Out.ar(0, out);
}).add;
)

x = Synth(\smooth_no_pattern);
x.set(\f_blip, 12, \n_harm, 50, \f_pul, 1000);
x.set(\n_harm, 30);
x.set(\f_pul, 10);
x.set(\f_blip, 10);
x.free;

(
p = Pdef(
	\smooth_pattern,
	Pbind(
		\instrument, \smooth,
		\dur, Pseq([5, 10], inf),
	)
).play;
)

p.stop;
p.play;

s.meter;
s.boot;