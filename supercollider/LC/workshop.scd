("Setup/Setup.scd").loadRelative;

~kick = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pbjorklund2(3,8)/4, \amp,0.5, \rate, Pwhite(0.1,2.4), \pan, Pwhite(-0.5, 0.5) );
~kick2 = Pbind(\instrument, \gplay1, \buf, d["k"][1], \dur, Pbjorklund2(5,8)/4, \amp,1, \rate, Pwhite(0.1,4.2), \pan, Pwhite(-0.75, 0.75) );
~kick3 = Pbind(\instrument, \gplay2, \buf, d["k"][2], \dur, Pbjorklund2(3,8)/2, \amp,1, \rate, Pwhite(0.1,4.2), \pan, Pwhite(-0.75, 0.75) );
~kick.play;
~kick2.play;
~kick3.play;

(
~bass = Pbind(\instrument, \ring1, \f, Prand([80,60],inf) * Prand([1,3/2,4/3],inf), \dur, 0.5, \a, Pwhite(1.2, 7), \d, Pwhite(0.5, 1.1), \amp, 1);
~bass.play;
)

~sn = Pbind(\instrument, \gplay2, \buf, d["s"][0], \dur, Pseq([0.5, Pbjorklund2(3,8,8)/4,0.25],inf), \rate, Pwhite(0.1, 4.8), \amp, 0.75);
~sn.play;

~flt_send = {Mix.ar([~sn.ar])};
~flt = {RLPF.ar(Mix.ar([~flt_send.ar]), LFNoise1.kr(0.1).range(500, 3000), SinOsc.kr(0.2).range(0.01,0.6))};
~flt.play;

~hh = Pbind(\instrument, \gplay2, \buf, d["ch"].choose, \dur, Pwrand([0.5, 0.25], [0.75,0.25],inf), \amp, 0.4, \rate, Pwhite(0.5, 1.8));
~hh.play;

~g1 = Pbind(\instrument, \gplay1, \buf, d["g"][0],\dur, Pbjorklund2(Prand([3,5,7],inf),Prand([8,13],inf),inf)/4, \amp, 1);
~g1.play;
~g2 = Pbind(\instrument, \gplay2, \buf, d["g"][2],\dur, Pbjorklund2(Prand([3,5,7],inf),Prand([8,13],inf),inf,4)/4, \amp, 1);
~g2.play;

