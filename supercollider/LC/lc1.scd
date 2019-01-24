("Setup/Setup.scd").loadRelative;

(
~k1 = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pwrand([1, Pbjorklund(Prand([3,5],2),8,4)/2], [0.9, 0.1],inf), \rate, Pwhite(0.5,2));
~k1.play;

~k2 = Pbind(\instrument, \gplay1, \buf, d["k"][1], \dur, Pwrand([0.5, Pbjorklund2(5,Prand([8,13],2),2)/4],[0.85, 0.15],inf), \rate, Pwhite(0.2, 1.5));
~k2.play;

~sn = Pbind(\instrument, \gplay2, \buf, d["s"][1], \dur, Pseq([0.5, Pseq([1],inf)],inf), \rate, Pwhite(0.5, 1.5), \amp, 0.1*Pwhite(1, 1.1), \rel, 0.01);
~sn.stop(3);

~oh = Pbind(\instrument,\bplay,\buf,d["oh"][0],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,0.1, \rate, Pwhite(0.5,0.7));
~oh.stop(4);

~g1 = Pbind(\instrument, \gplay1, \buf, d["g"][0],\dur, Pbjorklund2(Pseq([3,5],inf),Prand([8,11],inf))/4, \rate, Pwhite(0.2, 1.7));
~g1.play;

~g2 = Pbind(\instrument, \gplay2, \buf, d["g"][2],\dur, Pbjorklund2(Pseq([5,3],inf),Prand([8,11],inf))/4, \rate, Pwhite(0.2, 0.9));
~g2.play;

)
p.fadeTime = 1;

(
~bass = Pbind(\instrument, \ring1, \f, Prand([Pseq([80, 60, 40],4), Prand([80,60,90],8)],inf), \dur, Pwrand([0.5, 0.25, Pbjorklund2(3,8,4)/2],[0.5, 0.4,0.1],inf), \a, Pwhite(2,3), \d, Prand([1,1.5,0.5],inf));
~bass.play;

~sin = Pbind(\instrument, \sinfb, \freq, Prand([120, 60, 90, 40, 160],inf), \rel, 0.3, \amp, 0.1, \dur, Pbjorklund2(5,8)/4, \pan, Pwhite(-1,1));
~sin.play;
)

~sin.stop(10);
~bass.stop(10);
~k2.stop(20);~k1.stop(1);
~g1.stop(3); ~g2.stop(2);
