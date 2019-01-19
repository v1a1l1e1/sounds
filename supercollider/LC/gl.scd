("Setup/Setup.scd").loadRelative;

p.fadeTime=3;
p.clock.tempo = 1.5;

(
~g1 = Pbind(\instrument, \bplay, \buf, d["g"][2], \dur, Pwhite(0.25, 0.5), \stretch, Pwhite(0.8, 1.65), \rate, Pwhite(0.1, 1.5));
~g2 = Pbind(\instrument, \bplay, \buf, d["g"][1], \dur, Pwrand([Pwhite(0.5, 1,16), Pbjorklund(3,8,4)],[0.9,0.1],inf), \stretch, Pwhite(0.5, 1.7), \rate, Pwhite(1.1, 1.8));
~g1.play;
~g2.play;
)
(
~k = Pbind(\instrument, \bplay, \buf, d["k"][0],\dur, Pwrand([0.5, 0.25, Pbjorklund(3,8,4), Prand([0.5,0.25,0.75],inf)],[0.2,0.2,0.05,0.15].normalizeSum,inf), \stretch, Pwhite(0.9,1.1), \rate, Pwhite(0.25,0.85), \amp, 0.7);
~k.play;
)

(
~ring1 = Pbind(\instrument, \ring1, \f, Pkey(\freq), \scale, Scale.minor, \degree, Prand([2,4,5,7],inf), \octave, 2, \dur, Prand([0.25,  0.5],inf), \d, Pgauss(0.9,2), \a, Prand((1..40),inf),\pan,Pwhite(-0.7, 0.7), \amp, 0.5);
~ring1.play;
)

(
~ring2 = Pbind(\instrument, \ring1, \f, Pkey(\freq), \scale, Scale.minor, \degree, Prand([2,4,5,7].reverse,inf), \octave, Prand([0,2],inf), \dur, Prand([0.25, 0.5],inf), \d, Pgauss(0.6,1.5), \a, Prand((1..40),inf),\pan,Pwhite(-0.7, 0.7), \amp, 0.5);
~ring2.play;
)

(
~bk = Pbind(\instrument, \bplay, \buf, d["sk"][0], \dur,4, \amp, 0.8);
~bk.play;
)

~vsaw = {Pan2.ar(VarSaw.ar([80,81], LFNoise1.kr(0.1).range(-pi,pi), LFNoise1.kr(0.1).range(0.1, 1)),0,SinOsc.kr(0.1).range(-1,1))}
~vsaw.play;