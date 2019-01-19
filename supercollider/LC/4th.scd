("Setup/Setup.scd").loadRelative;

(
p.clear;
p.fadeTime = 5;
p.clock.tempo = 130/60;
)

(
~r = Pbind(\instrument, \vplay, \buf, d["sfx"][3], \dur, 0.125, \amp, 0.9, \pos, Pseq((0..100)/100, 1), \rel, 0.0001);
~r.play;
)

(
~k = Pbind(\instrument, \bplay, \buf, d["sk"][0], \dur, Pbjorklund2(3,8)/4, \rate, Pwhite(0.5,2), \amp,1);
~k.play;
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~oh.play;
)

(
~sn = Pbind(\instrument, \bplay, \buf, d["s"][0], \dur, 1, \amp, 1, \rate, Pwhite(0.5,1.5));
~sn.play;
)

(
~ring = Pbind(\instrument, \ring1, \amp, 1, \f, Pkey(\freq), \root, 0, \octave, Prand([2,-2],inf), \Scale, Scale.minor, \degree, Pseq([2,4,5,7,0],inf), \a, Pwhite(6,9), \d, Pwhite(0.3, 0.8), \dur, 0.25);
~ring.play;
~ring2 = Pbind(\instrument, \ring1, \amp, 1, \f, Pkey(\freq), \root, 0, \octave, Prand([1,0],inf), \Scale, Scale.minor, \degree, Pseq([2,4,5,7,0].reverse,inf), \a, Pwhite(6,9), \d, Pwhite(0.3, 0.8), \dur, 0.25);
~ring2.play;
~ring3 = Pbind(\instrument, \ring1, \amp, 1, \f, Pkey(\freq), \root, 0, \octave, Prand([2,0],inf), \Scale, Scale.minor, \degree, Pseq([2,4,5,7,0].scramble,inf), \a, Pwhite(6,7), \d, Pwhite(0.5, 1), \dur, 0.25);
~ring3.play;
)





~k.stop; ~oh.stop; ~sn.stop;

