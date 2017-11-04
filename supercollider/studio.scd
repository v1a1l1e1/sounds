(
SynthDef(\setto, {|out=0, freq=440,amp=0.5|
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.perc, doneAction:2);
	sig = sig*amp* env;
	Out.ar(out, sig);
}).add;
)

(
~scala = Pbind(
	\instrument, \setto,
	//\scale, Scale.major,
	//\freq, (Pxrand([[0, 4, 7],[0,3,7],[0,3,6], [0,4,8]],inf)+Pseq((60..72),inf)).midicps,
	\midinote, (Pseq([0,4,8],inf)+60),
	//\degree, Pseq((0..7), inf),
	\amp, 0.1,
	//\octave, 5,
	\dur, 0.5,

);
)

(
~triade = Pbind(
	\instrument, \setto,
	\scale, Scale.major,
	\degree, Pseq([0,2,4], inf),
	\octave, 4,
	\dur, 0.25,

);
)

(
~scala.play;
~triade.stop;
)
Scale.major.degrees;

Scale.directory;

s.meter;