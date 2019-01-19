("Setup/Setup.scd").loadRelative;

p.clock.tempo=135/60;

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur, Pwrand([1, Pseq([1, 0.5],4), Pbjorklund(Pseq([3,8],1),8,2)/4], [0.8, 0.15, 0.05],inf), \amp, 1);
~k.play;

~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~oh.play;

~t = Pbind(\instrument, \bplay, \buf, d["t"][0], \dur, 1, \amp, 1);
~t2 = Pbind(\instrument, \bplay, \buf, d["t"][0], \dur, Pbjorklund(Pseq([3,5],inf),8), \amp, 1, \rate, 2);
~t.play;

~sn_b = Pbind(\instrument, \bplay, \buf, d["s"][0], \dur, Pseq([0.5, Pseq([2],inf)],inf), \amp, Prand([1,0.5],inf), \rate, Pwhite(2, 2.5));
~sn = Pbind(\instrument, \bplay, \buf, d["s"][0], \dur, Pseq([0.5, Pseq([2],inf)],inf), \amp, Prand([1, 0.75],inf), \rate, Pwhite(1,1.5));
~sn.play;~sn_b.play;

)

(
~ring1 = Pbind(\instrument, \ring1, \scale, Scale.minor, \octave,Pwrand([0, 2, 4], [7, 1.5, 1.5],inf), \degree, Prand([2,-2, [2,4,5], [3,5,7]],inf), \a, 20, \dur, Pbjorklund2(5,8)/2, \amp, 0.5);
~ring1.play;
)