"Setup/Setup.scd".loadRelative;

p.clock.tempo=110/60;
p.fadeTime=5;

~gl = Pbind(\instrument, \tgrain, \in, d["g"][0], \dur,Pbjorklund2(3,8),\amp,0.5, \d,Prand([0.1,0.05],inf), \r, Pwhite(0.1,0.4), \fm, 0.1, \fM, 0.5, \on, 0);
~gl.stop(4);

~k = Pbind(\instrument, \gplay2, \buf, d["sk"][0], \dur, 4, \amp, 0.4);
~k.play;

~g1 = Pbind(\instrument, \gplay1, \buf, d["g"][0], \rate, Pwhite(0.1,2), \dur, Pbjorklund2(Prand([3,5],inf),8)/2);
~g2 = Pbind(\instrument, \gplay2, \buf, d["g"][2], \rate, Pwhite(1.5,4), \dur, Pbjorklund2(Prand([3,5],inf),8, 4)/2);
~g1.play; ~g2.play;

~m = Pbind(\instrument, \mu, \scale, Scale.minor, \octave, Prand([3,4],inf), \degree, Prand([1,3,5,2,4,6,3,5,7],inf));
~m.play;

~k1 = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pbjorklund2(Pseq([3,5],inf),8), \rate, Pwhite(0.7,1.3), \pan, Pwhite(0.1,1).linlin(0.1,1,-1,1));
~k2 = Pbind(\instrument, \gplay2, \buf, d["k"][2], \dur, Pbjorklund2(Pseq([5,3],inf),8), \rate, Pwhite(0.2,0.6), \pan, Pwhite(0.01,1).linlin(0.01,1,1,-1));
~k1.play;~k2.play;

~o = Pbind(\instrument, \gplay2, \buf, d["oh"][0], \dur, Pbjorklund2(3,8)/2, \amp, 0.3, \rate, Pwhite(0.1,2.5));
~o.play;

~g1.stop(10);~g2.stop(20);

~k1.stop(20);~k2.stop(20);

~o.stop(30);
~m.stop(12);
~k.stop(20);






