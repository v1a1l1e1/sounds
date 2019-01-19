("Setup/Setup.scd").loadRelative;

p.fadeTime=5;
~noise = {WhiteNoise.ar(0.2)}

~noise_f = {BPF.ar(~noise.ar, LFNoise1.kr(0.1,100,LFNoise1.kr(0.1).range(200,500)),0.6)}
~noise_f.play;

~noise_r = {RLPF.ar(~noise_f.ar,LFNoise1.kr(0.2).range(200,700),0.6)}
~noise_r.play;

~noise_fb = {CombC.ar(Decay.ar(~noise_r.ar,2),0.1, LFNoise1.kr(0.01).range(0.001, 0.01),3)}
~noise_fb.stop;

~pulse = {Pulse.ar(LFNoise2.kr(0.1).range(80,100), LFNoise1.kr(0.1).range(0.1,0.9),0.5)}
~pulseG = {GrainIn.ar(1, Impulse.kr(100),0.001,~pulse.ar)}
~pulseG.play;

~pulse2 = {Pulse.ar(LFNoise2.kr(0.1).range(150,200), LFNoise1.kr(0.1).range(0.1,0.9),0.5)}
~pulseG2 = {GrainIn.ar(1, Impulse.kr(20),0.0001,[~pulse.ar,~noise_fb.ar])}
~pulseG2.play;

(
~drone = {VarSaw.ar([80,80.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1)};
~drone2 = {VarSaw.ar([120,120.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1)};
~droneH = {RHPF.ar(~drone.ar,LFNoise1.kr(0.1).range(120,400),LFNoise1.kr(0.1).range(0.5, 0.1))};
~droneF = {DFM1.ar(Mix.ar([~drone2.ar,~droneH.ar]), LFNoise1.kr(0.1).range(100,800), LFNoise1.kr(0.1).range(0.1,0.9),0.9,0,0.003)};
~droneF.play;
)