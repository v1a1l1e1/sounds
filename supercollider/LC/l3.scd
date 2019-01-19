("Setup/Setup.scd").loadRelative;

(
~sinfb = Pbind(\instrument, \sinfb, \scale, Scale.major, \root, Pwhite(0,4).stutter(8), \octave, Pwrand([4, [3,4], [2,3,4]], [0.9, 0.08, 0.02], inf), \degree, Prand([[0,2,4], [2,4,6],[7,2,4], [1,2,3], [0, -2, -4]], inf), \dur, Pwhite(5,10), \atk, 2, \sus, 1, \rel, 3, \amp, 0.3, \fb, 0.1);
~modulation = {SinOsc.kr(0.1).range(0.01,1.41)};
~sinfb.play;
~sinfb.set(\fb, ~modulation);
)

(
d[\scale] = [Scale.major, Scale.minor].choose;
~chords = Pbind(\instrument, \bpfsaw, \dur, Pwhite(4.5, 7.0,inf),
	\scale, d[\scale],
	\degree, Pwrand([[0,2,4], [3,5,7], [4,6,8]], [0.5, 0.25, 0.25],inf),
	\cfmin, 100,
	\cfmax, 1500,
	\rqmin, Pexprand(0.02, 0.15, inf),
	\atk, Pwhite(2.0, 4.5,inf),
	\rel, Pwhite(6.5, 10.0, inf),
	\ldb, 6,
	\lsf, 1000,
	\octave, Pwrand([4,3,5], [0.6,0.3,0.1], inf),
	\amp, Pwhite(0.8, 2.0),
	\out, 0);

~sinfb = Pbind(\instrument, \sinfb, \scale, d[\scale], \root, 0, \octave, [4,5], \degree, Pseq([0, 0, 2, [4,5,6],[7,1,2],[6,7,8,9], [10, 12, 14, 15], 7,6,5],inf), \dur, Pbjorklund(Pwhite(6,8),8)/4, \amp,0.4, \fb, 0.9, \rel, 0.2);
~chords.play;
~sinfb.play;
)


(
p.clock.tempo=180/60;
~chords = Pbind(\instrument, \bpfsaw,
	\dur, Pwhite(9.5,15.0,inf),
	\scale, Scale.chromatic,
	\degree, Pxrand([\Em, \Am, \Bm7].chordProg,inf),
	\cfmin, 100,
	\cfmax, 1500,
	\detune, Pexprand(0.0001,1),
	\rqmin, Pexprand(0.02, 4.5, inf),
	\atk, Pwhite(2.0, 4.5, inf),
	\rel, Pwhite(6.5, 10.0, inf),
	\ldb, 13,
	\lsf, 1000,
	\octave, Pwrand([4,5,6], [0.8,0.15, 0.05],inf),
	\amp, Pwhite(0.8,1.5),
	\out, 0);
~chords.play;
)

(
p.clock.tempo=1;

d[\scale] = [Scale.zamzam, Scale.chromatic24, Scale.partch_o1, Scale.husseini, Scale.zanjaran, Scale.bhairav].choose.postln;

~sinfb = Pbind(\instrument, \sinfb, \scale, d[\scale], \octave, 4, \degree, Pseq((0..d[\scale].degrees.size-1),inf),\dur, 0.25, \amp, 0.3, \fb, 0.6, \rel, 0.3);
~sinfb.play;
)
