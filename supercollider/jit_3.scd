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

Pdefn(\x, Pseq([0,2,0,7,6,5,4,3], inf));
(
Task {
	var stream = Pdefn(\x).asStream;
	var val;
	loop{
		val = stream.next;
		(
			instrument: \wave,
			note: val
		).play;
		0.2.wait;
	}
}.play
);

/* ------------------- */

Pdefn(\x, Pseq([0,2,0,8,6,5,2,3,4], inf));
Pdefn(\x, Pseq([0,2,0,7,6,5,4,3].scramble + 4, inf));
Pdefn(\y, Pdefn(\x) + 2); //transposition
Pdefn(\z, Pdefn(\x) + Pseq([0, 5, 0, 7, 2], inf)); // variation
Pdefn(\a, Ptuple([Pdefn(\y), Pdefn(\z)])); // combimation in array of streams
(
Task{
	var stream = Pdefn(\a).asStream;
	var val;
	loop{
		val = stream.next;
		(instrument: \wave, note: val, sustain: rrand(0.5, 0.9)).play;
		0.2.wait;
	}
}.play
);

Pdefn(\x, Pseq([0,11],inf));
Pdefn(\x, Pseq([0,2,0,7,6,5,4,3].scramble + 5, inf));
Pdefn(\z, Pdefn(\x) + Pseq([1,5,1,11,1],inf));
Pdefn(\a, 5);
Pdefn.clear;

/* ------------------- */

Pdef(\a).play;
Pdef(\a, Pbind(\instrument, \wave));
Pdef(\a, Pbind(
	\instrument, \wave,
	\dur, Pseq([1, 3, 2, 3], inf)/6));
Pdef(\a).pause;
Pdef(\a).resume;
Pdef(\a).stop;