("Setup/Setup.scd").loadRelative;

p.fadeTime = 5;

~sin = {SinOsc.ar([80,82],0,0.5)}
~pulse = {Pulse.ar([20,21],SinOsc.kr(0.1).range(0.01, 1),0.5)}

(
~sp = {~sin.ar * ~pulse.ar};
~sp.play;
)

(
~delay = {CombC.ar(~sp.ar,1,LFNoise1.kr(0.1).range(0.1, 0.3),4)};
~delay.play;
)

~pulse2 = {Pulse.ar([40,41], SinOsc.kr(0.1).range(0.001,0.1),0.5)};

~delay = {CombC.ar(Mix.ar([~sin.ar,~pulse2.ar]),1, LFNoise1.kr(0.1).range(0.1,0.3),4)};

(
~noise = {RLPF.ar(WhiteNoise.ar(1), LFNoise1.kr(0.1).range(100,2000), SinOsc.kr(0.1).range(0.1,0.4),1)};
~noiseEnv = {EnvGen.ar(Env.perc(0.0001,0.1), Dust.kr(4))};
~noiseT = {Pan2.ar(~noise.ar * ~noiseEnv.ar, SinOsc.kr(0.1))};
~noiseT.play;
)

~noise.clear;
~noise = {RLPF.ar(WhiteNoise.ar(1), LFNoise1.kr(0.6).range(100,2000), SinOsc.kr(0.4).range(0.00001,0.2),1)};

(
~noiseD = {CombC.ar(Mix.ar([~noiseT]),1,0.4,7,1)};
~noiseD.play;
)

(
~pitchS = {PitchShift.ar(~noiseD.ar,0.2,TRand.kr(0.1,0.2, Dust.kr(0.5)))};
~pitchS.play;
)

/*alt*/
~noiseD = {CombC.ar(Mix.ar([~noiseT, (~pitchS.ar*0.1)],1,0.4,7,1))};
~noiseD = {CombC.ar(Mix.ar([~noiseT, (~pitchS.ar*LFNoise1.kr(0.01,0.2).abs)],1,0.4,7,1))};
~noiseD = {CombC.ar(Mix.ar([~noiseT, (~pitchS.ar*LFNoise1.kr(0.01,0.2).abs)],1,LFNoise1.kr(0.1).range(0.01,0.6),7,1))};

~delay.stop(20);
~sp.stop(20);

(
~noiseD_add = {DFM1.ar(Mix.ar([~delay.ar, ~sp.ar]), 500, SinOsc.kr(0.1).range(0.5, 2),1,0,0.03)};
~noiseD_add.play;
)

(
~henon = {Henon2DN.ar(2200,8800,LFNoise1.kr(1,0.2,1.2),LFNoise1.kr(1,0.15,0.15))*3.5};
~chaosEnv = {EnvGen.ar(Env.perc(0,0.02), Dust.kr(SinOsc.kr(0.01).range(1,10)))};
~chaos = {Splay.ar([~henon.ar*~chaosEnv.ar])};
~chaos.play;
)


/*rev*/

~room = {40};
~time = {3};
~verb = {GVerb.ar(~chaosEnv, ~room, ~time)};

~verb.play;

~saws = {LFSaw.ar([LFSaw.kr(0.1).range(100,1000).round(50), LFSaw.kr(0.11).range(100,1000).round(50)],0, 0.3)};
~saws.play;

~saws = {RLPF.ar(LFSaw.ar([LFSaw.kr(0.1).range(100,1000).round(50), LFSaw.kr(0.101).range(100,1000).round(50)],0, 0.8),1000, 0.8, 0.6, 3)};

(
~sawsD = {CombC.ar(~saws.ar, 1,0.5,10)};
~sawsD.play;
)

/*bit crush*/
~sawsD = {Decimator.ar(CombC.ar(~saws.ar, 1,0.5,10),2200,10)};
~sawsD = {Decimator.ar(CombC.ar(~saws.ar, 1,0.5,10),2200,5)};
~sawsD = {Decimator.ar(CombC.ar(~saws.ar, 1,0.5,10),2020,3)};


~noiseD = {LeakDC.ar(CombC.ar(Mix.ar([~sawsD.ar, ~noiseT.ar,(~pitchS.ar*LFNoise1.kr(0.01,0.2).abs)]),1,LFNoise1.kr(0.1).range(0.01,0.6),7,1))};
~noiseD = {LeakDC.ar(CombC.ar(Mix.ar([~sawsD.ar, ~noiseT.ar,~chaosEnv.ar,(~pitchS.ar*LFNoise1.kr(0.01,0.2).abs)]),1,LFNoise1.kr(0.1).range(0.01,0.6),7,1))*0.5};

~noiseD_add = {DFM1.ar(Mix.ar([~delay.ar, ~sp.ar, ~noiseD.ar]), LFNoise1.kr(100).range(100,10000), SinOsc.kr(0.1).range(0.5, 100),1,0,0.03)};

~noiseD = {LeakDC.ar(CombC.ar(Mix.ar([~sawsD.ar, ~noiseT.ar,~chaosEnv.ar,~noiseD_add.ar,(~pitchS.ar*LFNoise1.kr(0.01,0.2).abs)]),1,LFNoise1.kr(0.1).range(0.01,4),7,1))*0.5};

~delay2 = {LeakDC.ar(CombC.ar(~noiseD.ar,1,SinOsc.kr(0.1).range(0.0001,0.4),80))};
~delay2.play;

~noiseD = {LeakDC.ar(CombC.ar(Mix.ar([~delay2.ar, ~sawsD.ar, ~noiseT.ar,~chaosEnv.ar,~noiseD_add.ar,(~pitchS.ar*LFNoise1.kr(0.01,0.2).abs)]),1,LFNoise1.kr(0.1).range(0.01,4),7,1))*0.5};