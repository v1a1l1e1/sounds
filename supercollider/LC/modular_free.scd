p = ProxySpace.push(s);

p.fadeTime=5;

~freq = {LFNoise0.kr(0.25).range(20,40)};
~sine = {SinOsc.ar([~freq.ar, ~freq.ar+0.5],0,0.5)};
~pulse = {Pulse.ar([20,22],LFNoise1.kr(0.2).range(0.01,1))};

~pulseR = {HPF.ar(Pulse.ar([50,50.1],SinOsc.kr(0.2).range(0.05,0.7),0.2), LFNoise1.kr(0.1).range(100,500),0.2)};
~pulseR.play;

~sig = {~sine.ar * ~pulse.ar*0.25};
~sig.play;

~flt_send = {Mix.ar([~sig.play, ~pulseR.ar])};

~flt = {RLPF.ar(~flt_send.ar, LFNoise0.kr(0.2).range(80,400),SinOsc.kr(0.01).range(0.001,0.1))};

~flt.play;

~mod = {Pulse.ar(LFNoise0.kr(0.5).range(1,3))};

~sigM = {PitchShift.ar(~sig.ar*~mod.ar,0.2, TRand.kr(0.1,2,Dust.kr(4)))};
~sig.stop; ~sigM.play;

~noise = {RLPF.ar(WhiteNoise.ar(1), LFNoise1.kr(0.2).range(50,500), LFNoise1.kr(0.1).range(0.001,0.1))};
~noiseEnv = {EnvGen.ar(Env.perc(0.001,0.1),Dust.kr(2))};
~noiseD = {CombC.ar(Pan2.ar(~noise.ar),LFNoise0.kr(0.2).range(-1,1)), 0.4,1,3)};
~noiseRes = {RLPF.ar(~noiseD.ar, LFNoise0.kr(0.3).range(20,200),0.01)};
~noiseRes.play;~noiseD.play;

~pulseR_d = {RHPF.ar(CombC.ar(~pulseR.ar,0.4,0.25,3),LFNoise1.kr(0.1).range(80,600),SinOsc.kr(0.1).range(0.01,0.1))};
~pulseR_d.play;


b = Buffer.read(s,Platform.resourceDir +/+"sounds/a11wlk01.wav"); // remember to free the buffer later.
(
~y = {PlayBuf.ar(1, b.bufnum, BufRateScale.kr(b.bufnum) * 0.75, startPos: 92898, loop: 1)};
~woo = {WaveLoss.ar(~y.ar, EnvGen.kr(Env.new([199, 199, 150, 150, 199, 250], [20, 40, 60, 60, 100]), doneAction:2)+FSinOsc.kr(0.2 + XLine.kr(0.001, [1.3, 1.7], 90), 0, 50) * XLine.kr(0.00000001, 1, 60),200, mode: 2, mul: 0.4)};
~wooC = {(~woo.ar * 0.9) + (~woo.ar.reverse * 0.1)};
)

~wooC.play;

~sig.stop;~sigM.stop;
~flt.stop;
~noise.stop;
~noiseRes.stop;
~pulseR.stop;
~pulseR_d.stop;

p.clear;