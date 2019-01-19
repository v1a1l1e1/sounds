("Setup/Setup.scd").loadRelative

(
~kick1 = Pbind(\instrument, \gplay2, \buf, d["k"][2], \dur, Pwrand([Pseq([1,0.5],16),Pbjorklund2(5,8,4)],[0.85, 0.15],inf), \rate, Pwhite(0.5,2));
~kick1.play;

~kick2 = Pbind(\instrument, \gplay2, \buf, d["sk"][0], \dur, Prand([Pseq([0.5,1],8),Pbjorklund(Pseq([3,5],4),8,4)],inf), \rate, Pwhite(0.2,1.5));
~kick2.play;
)

(
~bass = Pbind(\instrument, \ring1, \f, Prand([80,60],inf), \a, Pwhite(2,4), \d, Prand([1,1.5,0.5],inf), \dur, 0.25);
~bass.play;
)

(
~sin = Pbind(\instrument, \sinfb, \scale, Scale.minor, \octave, Prand([4,3],inf), \root, 0, \degree, Prand([0,2,5,4,7],inf), \fb, 0.1, \amp, 0.4, \dur, Pwrand([0.5, Pbjorklund(3,8)],[0.9, 0.1],inf), \rel, 0.5);
~sin.play;
)
