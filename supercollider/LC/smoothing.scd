"Setup/Setup.scd".loadRelative;

p.fadeTime=15;

~sin1 = {SinOsc.ar([80,81],0,0.25)};
~sin2 = {SinOsc.ar([60,59],0,0.25)};

~sin = {~sin1.ar + ~sin2.ar};
~sin.play;

~pulse = {Pulse.ar([20,21],SinOsc.kr(0.1).range(0.1,0.6),0.5)};

~sin_mod = {~sin.ar * ~pulse.ar};
~flt = {RLPF.ar(~sin_mod.ar, Saw.kr(0.2).range(100,200),0.1)};
~flt.play;


~k = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Prand([4, 2, Pbjorklund2(5,8,2)/2],inf), \amp, 0.3);
~k.play;

~k2 = Pbind(\instrument, \gplay2, \buf, d["k"][2], \dur, Pwrand([Pseq([2, Pseq([4],16)],16), Pbjorklund2(Prand([3,5],2),8,4)/4],[0.9,0.1],inf), \amp, 0.2);
~k2.play;

~del_send = {Mix.ar([~k.ar, ~k_flt.ar, ~oh.ar])};

~flt_send = {Mix.ar([~k2.ar, ~oh.ar])};

~k_flt = {RLPF.ar(~flt_send.ar,LFNoise1.ar(0.5).range(80,200), SinOsc.ar(0.5).range(0.01,0.1),0.5)};
~k_flt.play;

~del = {CombC.ar(~del_send.ar, 1, 4, 7)};
~del.play;

~oh = Pbind(\instrument, \gplay2, \buf, d["oh"][0],\amp,0.1,\dur,Prand([4,2,Pbjorklund2(3,8,4)/2],inf));
~oh.play;

~del.stop(10);
~k_flt.stop(5);
~k2.stop(5);
~oh.stop(3);
~k.stop(5);
~flt.stop(5);
~sin.stop(2);


