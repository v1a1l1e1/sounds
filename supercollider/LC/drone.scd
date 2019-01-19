("Setup/Setup.scd").loadRelative;

(
~pulse = {Pan2.ar(RLPF.ar(Pulse.ar([60,60.5],LFNoise1.kr(0.1).range(0.1,0.9)),LFNoise1.kr(0.1).range(70,180),LFNoise1.kr(0.2).range(0.1,0.08)),SinOsc.kr(0.1))};
~pulse.play;
)

(
~sin = {SinOscFB.ar([80,80.5],LFNoise1.kr(0.3).range(0.3, 0.5))};
~sin.play;
)

(
~mix = {~pulse.ar * ~sin.ar};
~del = {CombC.ar(~mix.ar, 0.2, LFNoise1.kr(0.2).range(0.2,1),5)};
~flt = {RHPF.ar(~del.ar, LFNoise1.kr(0.2).range(200,5000), LFNoise1.kr(0.1).range(0.5, 0.01))};
~flt.play;
)

