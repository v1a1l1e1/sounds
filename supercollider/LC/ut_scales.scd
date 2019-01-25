~scale = Scale.chromatic(\pythagorean);

x = Pbind(\instrument, \default, \scale, ~scale, \degree,Prand([[0,2,4,7], [4,6,8,7],[0,2,4], [4,6,8], [3,5,7],[1,3,5]]/*[\Em, \Am7, \Bm7]*/.chordProg.stutter(2),inf), \dur, 0.25);
x.play;

y = Pbind(\instrument, \default, \scale, ~scale , \degree,Prand([[0,2,4], [4,6,8], [3,5,7],[1,3,5,7]]/*[\Em, \Am7, \Bm7]*/.chordProg.stutter(2),inf), \dur, Prand([0.25,0.5, 0.125],inf));
x.play; y.play; z.play;

(
c = \Em;
z = Pbind(
	\instrument, \default,
	\scale, ~scale,
	\octave, 4,
	\degree,ChordSymbol.asDegrees(c)/*Pxrand([\Cmajor, \Em7, \Am7].chordProg,inf)*/,
	\dur, Pseq([0.5, 0.5, 0.25, 0.25, 0.25, 1],inf)
);

)