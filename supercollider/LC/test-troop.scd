("Setup/Setup.scd").loadRelative;

(
~ring1 = Pbind(\instrument,\ring1,\dur, Pbjorklund2(Pseq([3,5],inf),8), \f, Pkey(\freq), \a, Pwhite(4,10), \d,Pwhite(2,4));
~ring1.play;
)