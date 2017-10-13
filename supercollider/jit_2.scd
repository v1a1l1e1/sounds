/* --- synth def --- */
(
SynthDef(\wave,{|out, freq=440, amp=0.1, sustain=0.1, mod = 0.2|
	OffsetOut.ar(out,
		EnvGen.ar(Env.perc(ExpRand(0.001, 0.05), sustain, amp), doneAction:2)
		*
		SinOsc.ar(freq, SinOsc.ar(sustain.reciprocal * 8, [0, Rand(0,pi)],mod))
	)

}).add
);

/* ------------------- */

(
Tdef(\x, {
	x = 4;
	y = 13;
	loop {
		x = (x * y) % 11;
		(
			instrument: \wave,
			note: x.postln,
			sustain: 0.5,
			octave: 6
		).play;
		0.125.wait;
	}
}).play
);

(
Tdef(\a,{
	10.do{
		(
			instrument: \wave,
			freq: 50.rand + 1500
		).play;
		0.03.wait;
	}
});

Tdef(\b, {
	[1, 5, 1, 2, 8, 4, 12].do {|x|
		(
			instrument: \wave,
			note: x + 8
		).play;
		0.1.wait;
	}
});

Tdef(\c, {2.wait;});

Tdef(\x, {
	loop{
		"a".postln;
		Tdef(\a).embed; //sequence
		1.wait;
		"b".postln;
		Tdef(\b).embed;
		2.wait;
		"a + b".postln;
		Tdef(\a).fork; //parallel
		Tdef(\b).fork;
		Tdef(\c).embed;
	}
}).play
);

Tdef(\a, {inf.do{
	(
		instrument: \wave,
		freq: 50.rand + 500
	).play;
	0.1.wait;
	}
});

Tdef(\a, {10.do{
	(
		instrument: \wave,
		freq: 50.rand + 500
	).play;
	0.1.wait;
	}
});

/* ------------------- */
(
Tdef(\a, {|in| // arg = environment
	in.at(\n).do{|i|
		in = (instrument: \wave, detune: 5.rand2).putAll(in);
		// putAll: adds all items of each argument to the dictionary
		in.postln.play;
		in.delta.wait;
	}
})
);

(
Tdef(\x, {|inevent|
	loop{
		Tdef(\a).embed((note:[15, 17], dur: 0.01, n:13));
		1.wait;
		Tdef(\a).embed((note:9, dur:0.4, n:4));
		1.wait;
	}
}).play;
)