"Setup/Setup.scd".loadRelative;

p.clock.tempo=110/60;
p.fadeTime=5;

~k = Pbind(\instrument, \gplay2, \buf, d["k"][0],\dur, Pbjorklund2(3,8)/4, \amp, 0.3, \rate, 1);
~k.play;~k2.play;
~k2 = Pbind(\instrument, \gplay2, \buf, d["k"][2],\dur, Pbjorklund2(3,8,inf,3)/4, \amp, 0.3, \rate, Pwhite(0.1,1.2));

~sk = Pbind(\instrument, \gplay2, \buf, d["sk"][0], \dur,4, \amp, 0.6);
~sk.play;
