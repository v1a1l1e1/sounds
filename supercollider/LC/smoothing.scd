"Setup/Setup.scd".loadRelative;

p.fadeTime=5;

~sin1 = {SinOsc.ar([80,81],0,0.25)};
~sin2 = {SinOsc.ar([60,59],0,0.25)};

~sin = {~sin1.ar + ~sin2.ar};
~sin.play;

~pulse = {Pulse.ar([20,21],SinOsc.kr(0.1).range(0.1,0.6),0.5)};

~sin_mod = {~sin.ar * ~pulse.ar};
~flt = {RLPF.ar(~sin_mod.ar, Saw.kr(0.2).range(100,200),0.1)};
~flt.play;

