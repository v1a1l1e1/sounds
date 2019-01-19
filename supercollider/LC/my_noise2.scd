~vsaw = {VarSaw.ar([80,81], LFNoise1.kr(0.1).range(-pi,pi), LFNoise1.kr(0.1).range(0.1, 1))}
~vsaw.play;

~pulse = {Pulse.ar([2,2.5], LFNoise1.kr(0.1).range(0.001,0.4))};

(
~synth = {~vsaw.ar * ~pulse.ar};
~synth.play;
)
(
~pulseD = {RLPF.ar(CombC.ar(~pulse.ar, 1, LFNoise1.kr(0.1).range(0.5, 1), LFNoise1.kr(0.1).range(5,7),1), LFNoise1.kr(0.1).range(200, 1000), LFNoise1.kr(0.1).range(0.01, 0.1))};
~pulseD.play;
)

~flt = {DFM1.ar([~pulseD.ar], LFNoise1.kr(0.1).range(100, 3000), LFNoise1.kr(0.1).range(0.9,1.01), 0.8,0,0.003,0.9)};
~flt.play;

~noise = {WhiteNoise.ar};

~noise = {RLPF.ar(~noise.ar,LFNoise1.kr(0.1).range(60,800),LFNoise1.kr(0.1).range(0.1,0.5))}
~noise.play;