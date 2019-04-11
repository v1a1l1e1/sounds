("Setup/Setup.scd").loadRelative;

~k = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pbjorklund2(Pseq([3,3,3,5],inf),Prand([8,13],inf))/4, \rate, Pwhite(0.3,1.5), \amp, 0.5);

~hh = Pbind(\instrument, \gplay2, \buf, d["ch"][0], \dur, Pwrand([0.25, Pseq([0.125],2), Pseq([0.125/4],4)],[0.85,0.15, 0.05],inf), \amp, 1, \rate, Pwhite(0.3, 2));

~oh = Pbind(\instrument, \gplay2, \buf, d["oh"].choose, \dur, Pwrand([0.25, Pseq([0.25, Pbjorklund2(Prand([3,5],inf),Prand([8,11,13],inf))/8],16)],[0.7,0.3],inf), \amp, 0.7, \rate, Pwhite(0.1, 3));

~sn = Pbind(\instrument, \gplay2, \buf, d["s"][1], \dur, Pwrand([2, Pbjorklund2(3,8)/4], [0.9,0.1],inf), \amp, Pwhite(0.3,0.8));
~sn.play;

p.fadeTime = 4;

~k.play;
~hh.play;
~oh.play;


~lpfS = {Mix.ar([~hh.ar])};
~lpf = {RLPF.ar(Mix.ar([~lpfS.ar]), SinOsc.kr(0.1).range(300, 4000), LFNoise1.kr(0.2).range(0.05, 0.7));};
~lpf.play;