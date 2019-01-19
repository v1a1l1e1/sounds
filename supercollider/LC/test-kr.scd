("Setup/Setup.scd").loadRelative;

p.fadeTime=10;

~mod = {LFNoise1.kr(0.1).range(0.2, 1.6)};

~saw = {Pan2.ar(VarSaw.ar([70,70.1]*~mod.kr, LFNoise1.kr(0.1).range(-pi,pi), LFNoise1.kr(0.1).range(0.1,1),0.5),SinOsc.kr(0.1))};
~sin = {Pan2.ar(SinOscFB.ar([80,80.1], ~mod.kr, 0.5), LFNoise1.kr(0.1).range(-1,1))};

(
~synth = {~sin.ar*~saw.ar}; ~synth_b = {~sin.ar*~saw.ar};
~synth.play; ~synth_b.play;
)

(
~flt = {Pan2.ar(RHPF.ar([~synth.ar, ~synth_b.ar], SinOsc.kr(0.1).range(60,100), LFNoise1.kr(0.05).range(0.9,0.01),0.8), LFNoise1.kr(0.1).range(-1,1))};
~flt.play;
)

~del = {Pan2.ar(CombC.ar([~flt.ar, ~res.ar, ~noiseE.ar], 1, LFNoise1.kr(0.1).range(0.5,0.8),9), SinOsc.kr(0.1).range(-1,1))};
~del.play;

(
~res = {DFM1.ar(RHPF.ar([~del.ar, /*(~drinD.ar)*/].flatten, LFNoise1.kr(0.1).range(100,500), LFNoise1.kr(0.02).range(0.7,0.3)),LFNoise1.kr(0.3).range(300,700), LFNoise1.kr(0.1).range(0.1, 0.001))};
~res.play;
)

(
~noiseS = {WhiteNoise.ar(1)};
~noiseE = {EnvGen.ar(Env.linen, Dust.kr(0.01!2))};
)

(
~drin = {Pan2.ar(Pulse.ar([40, 40.5],LFNoise1.kr(0.1).range(-pi/2, pi/2)), SinOsc.kr(0.1).range(-1,1))};
~drinD = {RLPF.ar(CombN.ar(~drin.ar, 0.2, LFNoise1.kr(0.2).range(0.5,2), 7), LFNoise1.kr(0.1).range(80,150), LFNoise1.kr(0.2).range(0.1, 0.01),1.01)};
~drinD.play;
)


p.clear()


