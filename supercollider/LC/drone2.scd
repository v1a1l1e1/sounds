("Setup/Setup.scd").loadRelative;

p.fadeTime=2;

(
~pulse = {RLPF.ar(Pulse.ar([60,60.1], LFNoise1.kr(0.1).range(0.1,1)), LFNoise2.kr(0.05).range(300, 2000), LFNoise1.kr(0.2).range(0.001, 0.1),0.9)};
~pulse.play;
)

~g1 = Pbind(\instrument, \bplay, \buf, d["g"][2], \dur, Pwhite(0.25, 0.5), \stretch, Pwhite(0.8, 1.65), \rate, Pwhite(0.1, 1.5));
~g2 = Pbind(\instrument, \bplay, \buf, d["g"][1], \dur, Pwrand([Pwhite(0.5, 1,16), Pbjorklund(3,8,4)],[0.9,0.1],inf), \stretch, Pwhite(0.5, 1.7), \rate, Pwhite(1.1, 1.8));
~g1.play;
~g2.play;

(
~mix = {Mix.ar([~g1.ar, ~g2.ar])};
~del = {CombC.ar(~mix.ar,0.2, LFNoise1.kr(0.1).range(0.1, 0.6), 8)};
~del.play;
)

~g1.stop(20);~g2.stop(45);

(
~delF={DFM1.ar(~del.ar, SinOsc.kr(0.02).range(400,3000),LFNoise1.kr(0.1).range(0.1, 0.01), 0.8,0,0.003)};
~delF.play;
)

(
~dev = {LFNoise1.kr(0.1).range(2/3, 3/2)};
~sfb = {SinOscFB.ar([90,90.05]* ~dev.ar, LFNoise2.kr(0.03).range(0.1, 1.1))};
~sfbF = {RHPF.ar(~sfb.ar, LFNoise2.kr(0.2).range(100,300),SinOsc.kr(0.05).range(0.01, 0.05))};
~sfbF.play;
)

~sfbF.stop(50);
