(
SynthDef(\smooth_pattern, { |freq = 10, nh = 10, amp_freq=12, gate = 1|
    var audio = Blip.ar(
		(SinOsc.kr(freq).range(0, freq/2*3))!2,
		nh,
		Dust2.kr(amp_freq!2).range(0,1),
		0.5;
	);
    var env = Linen.kr(gate, 1, 1, 1, doneAction: 2);
	var out_sig = audio * env;
	out_sig = FreeVerb.ar(out_sig, 0.4, 0.7, XLine.kr(0.1, 0.7, 2));

    OffsetOut.ar(0, out_sig );
}).add;
)

(
Pdef(
	\smooth,
	Pbind(
		\instrument, \smooth_pattern,
		\freq, Prand([10, 20,40,10, 38 ,30, 25, 16],inf),
		\nh, Prand([10,100, 50, 40, 60],inf),
		\amp_freq, Prand([10, 15, 9],inf),
		\dur, Pseq([0.8, 1.01],inf),
		\stretch, 2,
);
).play(quant:2);
)
//).quant_(2);

)
s.quit;

Pdef(\smooth).stop;

(
w = Window.new("my own scope", Rect(20, 20, 300, 300));
w.view.decorator = FlowLayout(w.view.bounds);
c = Stethoscope.new(s, view:w.view);
w.onClose = { c.free }; // don't forget this
w.front;
)

s.meter