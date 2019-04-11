("Setup/Setup.scd").loadRelative;

~kick = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, 1, \amp, 1);

~oh = Pbind(\instrument,\gplay2,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);

~sn = Pbind(\instrument, \gplay2, \buf, d["s"][0],\dur, Pseq([0.25, 0.5,1],inf), \amp, 1);

(
~kick.play;
~oh.play;
~sn.play;
)

/*----------

RITMI EUCLIDEI

Pbjorklund2(3,8);
Pbjorklund2(5,8);
Pbjorklund2(Pseq([3,5],inf),8);
Pwrand([1, Pbjorklund2(3,8,16)/4],[0.9, 0.1],inf);

----------*/





