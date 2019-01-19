("Setup/Setup.scd").loadRelative;

p.clear;
p.fadeTime=4;

(
~s1 = {RLPF.ar(VarSaw.ar([50,50.1]+LFNoise1.kr([0.1,0.11]).range(-2,3),LFNoise1.kr(0.1).range(0, 0.3), LFNoise1.kr(0.2).range(-pi,pi)), [100,101], LFNoise1.kr(0.1).range(0.1,0.3))};
~s1.play;

~s2 = {RLPF.ar(VarSaw.ar([80,80.05]+LFNoise1.kr([0.1,0.11]).range(-2,3),LFNoise1.kr(0.2).range(0, 0.4), LFNoise1.kr(0.1).range(-pi/2,pi/2)), [100,101], LFNoise1.kr(0.1).range(0.1,0.6))};
~s2.play;
)

(
~flt = {DFM1.ar(~s1.ar+~sig2.ar, SinOsc.kr(0.1).range(75,150).round(25), LFNoise1.kr(0.1).range(0.1, 0.6),0.8,0,0.003)};
~flt.play;
)

(
~k = Pbind(\instrument, \bplay, \buf, d["sk"][0], \dur,4,\amp,0.9, \rate, Pwhite(0.8,1.1));
~k.play;
)

(
~k1 = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur, Pwrand([Pseq([0.5, 0.25],4), 0.5, Pbjorklund2(Pseq([3,5],2),8,4)/4],[0.3,0.5,0.2],inf), \rate, Pwhite(0.75,1.15), \amp, Pseq((2..8)/10,inf));
~k1.play;
)

(
~pulse = {Pan2.ar(Pulse.ar([2,1.5], LFNoise1.kr(0.1).range(0.001,0.4)),SinOsc.kr(0.1).range(-1,1))};
~pulseD = {RLPF.ar(CombC.ar(~pulse.ar, 1, LFNoise1.kr(0.1).range(0.5, 1), LFNoise1.kr(0.1).range(5,7),1), LFNoise1.kr(0.1).range(200, 1000), LFNoise1.kr(0.1).range(0.01, 0.1),0.1)};
~pulseD.play;
)

/*--- da ambient a amb2 --*/ si collegano bene!
(
~s2 = {VarSaw.ar([80,80.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1)};
~s1.stop(20); ~flt.stop(20);
)
~s2.stop(30); // <-- avviare ~drone in amb2


(
~s3 = {RLPF.ar(VarSaw.ar([110,110.1]+LFNoise1.kr([0.1,0.11]).range(-8,2),LFNoise1.kr(0.2).range(0, 0.6), LFNoise1.kr(0.1).range(-pi,pi),0.5), [200,800], LFNoise1.kr(0.1).range(0.1,1.01))};
~s3.play;
~s3D = {CombC.ar(~s3,0.3, LFNoise1.kr(0.1).range(0.1,0.4),LFNoise1.kr(0.1).range(6,8))};
~s3D.play;
)


