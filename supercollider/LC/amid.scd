"Setup/Setup.scd".loadRelative;

~g1= Pbind(\instrument, \g_play1, \buf, d["g"][0], \dur,1, \amp, 0.6, \rate, Pwhite(0.05, 1.6,inf));
~g2= Pbind(\instrument, \g_play2, \buf, d["g"][1], \dur,0.5, \amp, 0.6, \rate, Pwhite(0.01,2.0,inf), \pan,Prand([0,0.5,-0.5,-1,1,],inf));

~rev_send = {Mix.ar([~g1.ar, ~g2.ar])};

~rev = {FreeVerb.ar(~rev_send.ar, 0.9, 0.8, 0.75)};

~flt = {LPF.ar(~rev.ar, LFNoise0.kr(0.1).range(80,200))};
~flt.play;

~flt_del = {CombC.ar(~flt.ar, 0.6, 0.5,0.5)};
~flt_del.play;

~k1 = Pbind(\instrument, \kick, \dur, Pbjorklund2(Prand([3,5],inf),8)/Prand([2,4],inf));
~k2 = Pbind(\instrument, \kick2, \dur, Pbjorklund2(Prand([3,5],inf),Prand([8,11],inf),inf,3)/Prand([2,4],inf));

~k1.play;
~k2.play;

~flt_del.stop(10);
~flt.stop(20);
~g1.stop;~g2.stop;

~k1.stop(3);~k2.stop(3);

~g2.stop;

p.fadeTime = 5