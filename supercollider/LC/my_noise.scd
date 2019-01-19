("Setup/Setup.scd").loadRelative;

~sin = {SinOsc.ar([20,21],0,0.5)};
~pulse = {Pulse.ar([30,31], LFNoise1.kr(0.1).range(0.01,1),0.5)};

(
~sinpulse = {~sin.ar * ~pulse.ar};
~sinpulse.play;
)

~vsaw = {VarSaw.ar([80,80.5], SinOsc.kr(0.1).range(0.1, 1), LFNoise1.kr(0.1).range(0.001, 0.6), 0.3)};

(
~synth = {~sinpulse.ar*~vsaw.ar};
~synth.play;
)

~synthE = {EnvGen.kr(Env.perc(0.0001, 1), Dust.kr(0.1).range(0.5, 10))};

~synthT = {~synth*~synthE};
~synthT.play;~synth.stop;

~synthD = {CombC.ar([~synthT.ar,~synthF.ar], 1, LFNoise1.kr(0.1).range(0.5, 0.8), LFNoise1.kr(0.1).range(4,7))};
~synthD.play;

~synthF = {Ringz.ar([~synthT.ar, ~synthD.ar], SinOsc.kr(0.1).range(100, 2000), 7 )};
~synthF.play;


