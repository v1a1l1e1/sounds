~vsaw = {VarSaw.ar([80,81], LFNoise1.kr(0.1).range(-pi,pi), LFNoise1.kr(0.1).range(0.1, 1))}
~vsaw.play;

~pulse = {Pulse.ar([2,2.5], LFNoise1.kr(0.1).range(0.001,0.4))};

(
~synth1 = {~vsaw.ar * ~pulse.ar};
~synth1.play;
)
(
~pulseD = {RLPF.ar(CombC.ar(~pulse.ar, 1, LFNoise1.kr(0.1).range(0.5, 1), LFNoise1.kr(0.1).range(5,7),1), LFNoise1.kr(0.1).range(200, 1000), LFNoise1.kr(0.1).range(0.01, 0.1))};
~pulseD.play;
)

~flt = {DFM1.ar([~pulseD.ar], LFNoise1.kr(0.1).range(100, 3000), LFNoise1.kr(0.1).range(0.9,1.01), 0.8,0,0.003,0.9)};
~flt.play;

(
~r = {60};
~synth = Pbind(\instrument, \sinfb, \freq, Pwrand([Pseq((1..2).round(0.25),inf),Pseq((1..4).round(0.25),inf)],[0.9, 0.1],inf)*Pkr(~r), \amp, 0.2, \dur, Pbjorklund(3,8)/16, \fb, Pseq((6..11)/10,inf));
~synth.play;
~synth2 = Pbind(\instrument, \sinfb, \freq, Pwrand([Pseq((1..2).round(0.25),inf),Pseq((1..3).round(0.25),inf)],[0.9, 0.1],inf)*Pkr(~r), \amp, 0.1, \dur, Pbjorklund(3,8,inf,4)/16, \fb, Pseq((6..11)/10,inf));
~synth2.play;
)

~noise = {WhiteNoise.ar(0.1)};

~noise = {RLPF.ar(~noise.ar,LFNoise1.kr(0.1).range(60,800),LFNoise1.kr(0.1).range(0.1,0.5),0.5)}
~noise.play;

(
~synth4 = Pbind(\instrument, \sinfb, \freq, Pwrand([Pseq((1..10)/2,inf), Pseq((1..10)/5, inf)], [0.6,0.4],inf)*Pkr(~r),\fb, Pwhite(0.3,0.93), \amp, 0.7, \dur, Pbjorklund(Prand([3,8,9],inf),Prand([8,16],inf)));
~synth4.play;
)

(
~synth3 = Pbind(\instrument, \sinfb, \freq, Pwrand([Pseq([0.5, 1],inf),Pseq((1..20)/4.round(3),inf), Pseq((1..15)/5.round(3), inf)], [0.6,0.2,0.2],inf)*Pkr(~r),\fb, Pwhite(0.3,1), \amp, 0.7, \dur, Pbjorklund(Prand([3,8,9],inf),Prand([8,16],inf)));
~synth3.play;
)

(
~g1 = Pbind(\instrument, \bplaym, \buf, d["g"][0], \dur, Pbjorklund(3,8)/2, \rate, Pwhite(0.5,3), \amp, 0.2);
~g1.play;
~g2 = Pbind(\instrument, \bplay, \buf, d["g"][1], \dur, Pbjorklund2(3,8)/4, \rate, Pwhite(0.6, 2.5), \amp, 0.2);
~g2.play;
~g3 = Pbind(\instrument, \bplay, \buf, d["g"][2], \dur, Pbjorklund2(5,8)/4, \rate, Pwhite(0.2, 5), \amp, 0.2);
~g3.play;
)

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur,Pwrand([1, Pseq([0.5,0.25],4),Pbjorklund2(Pseq([3,5],4),8, 4)/4], [0.45, 0.35, 0.2],inf), \amp, 1.9, \rate, Pwhite(0.8,1.3));
~k.play;

~k2 = Pbind(\instrument, \bplaym, \buf, d["k"][1], \dur,Pwrand([0.5, Pseq([0.5,0.25],4),Pbjorklund2(Pseq([3,5],4),8,3)/4], [0.6, 0.2, 0.2],inf), \amp, 1.9, \rate, Pwhite(0.8,1.1));
~k2.play;
)
(
~sk = Pbind(\instrument, \bplay, \buf, d["sk"][0], \amp, 1.9, \dur,4,\rate,Pwhite(0.7,1.5));
~sk.play;
)

p.fadeTime = 5;