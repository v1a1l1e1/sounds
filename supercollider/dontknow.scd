(
SynthDef(\test,{|freq=60, f_width=12|
	var out, width, env;
	width = LFSaw.kr(f_width).exprange(0.001, 0.999);
	env = EnvGen.kr(Env.triangle, doneAction:2);
	out = Pulse.ar(freq!2, width);
	out = out * 0.03 * env;
	Out.ar(0, out);
}).add;
)

(
var f_pattern, f_stream, f_value;
f_pattern = Pseq([
	Pseq([70], 4),
	Pseq([50, 70, 60, 60, 90].scramble, 5),
	Prand([Pseq([50, 60]),Pseq([80, 50]),Pseq([70, 50])], 10),
	Pseq([120, 200], 10),
	Pseq([50, 70, 60, 60, 90].scramble, 5),
	Pseq([0], inf)
]);

f_stream = f_pattern.asStream;

k = Task({
	loop({
		if ((f_value = f_stream.next)>0,{Synth(\test, [\freq, f_value, \f_width, 3]);});
		(1/2).wait;
	})
}).play;

)

s.plotTree;
s.scope;
s.boot;