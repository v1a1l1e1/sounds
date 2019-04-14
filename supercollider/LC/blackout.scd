"Setup/Setup.scd".loadRelative;

~k1 = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pwrand([1,0.5,0.25],[0.8,0.15,0.05],inf), \amp, 0.3, \pan, 0, \rate, Prand((0.1 .. 1.5),inf));

~k1.play;~k2.play;~k3.play; ~oh.play;

~k2 = Pbind(\instrument, \gplay2, \buf, d["k"][2], \dur, Pseq([0.5, Pwrand([Pseq([1],8),Pbjorklund2(3,8,4)/4],[0.85,0.15],inf)],inf), \amp, 0.3, \pan, 0, \rate, Prand((0.1 .. 1.3),inf));

~k3 = Pbind(\instrument, \gplay2, \buf, d["sk"][0], \rate, Prand((0.75 .. 1.1),inf), \dur, Pbjorklund2(Prand([3,5,7],inf),Prand([8,11,13],inf))/4, \amp, 0.2);

~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Prand([2,1],inf)],inf),\amp,0.3, \rate, Prand([1,0.5,0.75,1.1],inf));
~oh.play;

~h = Pbind(\instrument, \gplay2, \buf, d["ch"].choose, \rate, Prand((1..1.3),inf),\dur, 0.5, \amp, 0.1);
~h.play;

~k2.stop(5);
~k1.stop(10);
~k3.stop(20);
~h.stop(1);
~oh.stop(5);

~rev_send = {Mix.ar([~k1.ar])};
~rev = {CombC.ar(~rev_send.ar, 0.3,0.4,1.2,0.1)};
~rev.stop;

p.fadeTime = 5;


~g = Pbind(\instrument,\gplay1, \buf, d["g"][0], \dur, Pbjorklund2(Pseq([3,5],inf),8)/4,\rate, Prand((0.5..1.5),inf),\amp,0.3);
~g2 = Pbind(\instrument,\gplay1, \buf, d["g"][0], \dur, Pbjorklund2(Pseq([5,3],inf),8)/4,\rate, Prand((1.4..2.5),inf),\amp,0.3);
~g3 = Pbind(\instrument,\gplay2, \buf, d["g"][1], \dur, Pbjorklund2(3,8,inf,2)/4,\rate, Prand((0.5..1.5),inf),\amp,0.3);
~g4 = Pbind(\instrument,\gplay2, \buf, d["g"][2], \dur, Pbjorklund2(5,8,inf,2)/4,\rate, Prand((1.4..2.5),inf),\amp,0.3);
~g.play; ~g2.play;~g3.play;~g4.play;

