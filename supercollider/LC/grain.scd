("Setup/Setup.scd").loadRelative

~g = Pbind(\instrument, \tgrain, \in, d["l"][0], \dur, Pseq([1],1), \fm, 20, \fM, 100, \rate, 1, \d, 1)

~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur, Pbjorklund(5,8)/2, \rate, Pwhite(0.5,1.2));
~k.play;
~k2 = Pbind(\instrument, \bplay, \buf, d["k"][2], \dur, Pbjorklund2(Pseq([3,5,7],inf),Prand([8,13],inf))/2, \amp, 0.2, \rate, Pwhite(0.3,1.7));
~k2.play;

~ring = Pbind(\instrument, \ring1, \f, Prand([40,60,90],inf), \a, Pwhite(4,15), \d, Pwhite(2,7), \dur, Prand([0.5, 1, 0.5,0.25],inf), \amp, 0.1);
~ring.play

~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Prand([1,0.5],inf)],inf),\amp,0.2);
~oh.play;


~fx = Pbind(\instrument, \gplay2, \buf, d["fx"][2],\dur, 1, \pos, Pwhite(0.1,50),\rate, Pwhite(0.5, 1.1),\amp, 0.2);
~fx.play;


~oh.stop(30)
~fx.stop(20)

~k.stop(10); ~k2.stop(20);

~ring.stop(5)

p.stop(4)
~g.clear