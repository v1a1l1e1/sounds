("Setup/Setup.scd").loadRelative;

(
p.clock.tempo=1.5;
~r = {75};
)
(
~sinfb1 = Pbind(\instrument, \sinfb, \freq, Pseq((1..10), inf)*Pkr(~r), \dur, Pwrand([0.25, Pseq([0.125],2)],[0.9,0.1],inf), \amp, 0.3, \fb, Pwhite(0.1,0.4), \rel, 0.3);
~sinfb1.play;
)

(
~sinfb2 = Pbind(\instrument, \sinfb, \freq, Pseq((1..10).reverse, inf)*Pkr(~r), \dur, Pwrand([0.25, Pseq([0.125],2)],[0.9,0.1],inf), \amp, 0.3, \fb, Pwhite(0.1,0.4), \rel, 0.3);
~sinfb2.play;
)

(
~sinfb3 = Pbind(\instrument, \sinfb, \freq, Pseq((1..10).scramble, inf)*Pkr(~r), \dur, Pwrand([0.25, Pseq([0.125],2)],[0.9,0.1],inf), \amp, 0.3, \fb, Pwhite(0.1,0.4), \rel, 0.3);
~sinfb3.play;
)

~sinfb1.play;
~sinfb2.play;
~sinfb3.play;


/*STABS*/

(
p.clock.tempo = 2.4;
~stab1 = Pbind(\instrument, \bplay, \buf, d["stab"][1], \eucl, Pwhite(3,3), \dur, Pbjorklund2(Pkey(\eucl), 8)/4, \amp, 2, \rate, Pseq([1,1,1,1,1,1,0.9,1,1],inf).stutter(3));
~stab1.play;
)

(
~stab2 = Pbind(\instrument, \bplay, \buf, d["stab"][1], \eucl, Pwhite(3,11), \dur, Pbjorklund2(Pkey(\eucl), 16)/4, \amp, 2, \rate, Pseq([1,1,1,1,1,1,0.9,1,1],inf).stutter(3)*2);
~stab2.play;
)
(
~stab3 = Pbind(\instrument, \bplay, \buf, d["stab"][1], \eucl, Pwhite(3,16), \dur, Pbjorklund2(Pkey(\eucl), 16)/4, \amp, 2, \rate, Pseq([1,1,1,1,1,1,0.9,1,1],inf).stutter(3)*4);
~stab3.play;
)

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur, Pbjorklund2(3,8)/4,\amp, 1, \rate, Pseq([1.1,1.9],inf));
~k2 = Pbind(\instrument, \bplay, \buf, d["k"][2], \dur, Pbjorklund2(3,8)/4,\amp, 1, \rate, Pseq([1.1,1.9],inf)*2);
~sn = Pbind(\instrument, \bplay, \buf, d["s"][0], \dur, Pbjorklund2(Pwhite(1,6),16)/4,\amp, 1);
~fx = Pbind(\instrument, \bplay, \buf, d["fx"][0], \dur, Pwhite(1,6),\amp, 1);
~k.play; ~k2.play; ~sn.play;~fx.play;
)

/* Place */

(
~ring1 = Pbind(\instrument, \ring1, \f, Pkey(\freq), \scale, Scale.minor, \degree, Place([0,7,[2,4,3,5,4,6,8,11]],inf), \octave, 3, \dur, 0.25, \d, 0.6, \a, Pseq((1..40),inf),\pan,0, \amp, 0.5);
~ring1.play;
)
