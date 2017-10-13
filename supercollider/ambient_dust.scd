(
SynthDef(\noiz, {|freq = 50, pan = 0, attack = 0.01, release = 0.3|
	var sig, env;
	sig = SinOsc.ar(Dust2.kr(LFClipNoise.kr(freq!2).exprange(50,200)));
	env = EnvGen.ar(Env.perc(attack, release),doneAction:2);
	sig = Pan2.ar(sig, pan);
	Out.ar(0, sig);
}).add
);

Pdefn(\x, Prand([50, 70, 30, 60],inf));

(
Tdef(\start, {
	10.do{
		(
			instrument: \noiz,
			freq: Pdefn(\f).asStream.next,
			pan: Pseq([-1,-0.5, 0, 0.5, 1],inf),
		).play;
		0.01.wait;
	}
});
);

(
Tdef(\continue, {
	[1000, 800, 750, 1200].do{|hz|
		(
			instrument: \noiz,
			freq: hz,
			pan: Pseq([-1,-0.5, 0, 0.5, 1].scramble,inf),
		).play;
		0.05.wait;
	}
	});
);

Tdef(\silence,{0.1.wait});

(
Tdef(\global, {
	loop{
		Tdef(\start).embed;
		0.01.wait;
		Tdef(\continue).embed;
		0.01.wait;
		Tdef(\start).fork;
		Tdef(\continue).fork;
		Tdef(\silence).embed;
	}
}).play;
);

/* --- scope --- */
(
w = Window.new("my own scope", Rect(20, 20, 400, 500));
w.view.decorator = FlowLayout(w.view.bounds);
c = Stethoscope.new(s, view:w.view);
w.onClose = { c.free }; // don't forget this
w.front;
)