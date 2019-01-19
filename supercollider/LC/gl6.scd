("Setup/Setup.scd").loadRelative;

p.fadeTime = 4;

Ndef(\Dust, {Pan2.ar(RHPF.ar(Dust.ar(LFNoise1.kr(2).range(2,20), 0.25), LFNoise1.kr(0.4).range(300,400), 0.01,2),LFNoise1.kr(0.1).range(-1,1))});
Ndef(\Dust).play;

(
l = Prewrite(0,(
	0: #[0,0.25,0.5,0.25,0.5,0],
	0.5: #[0.5,0.125, 0.25, 0.125,0.25,0.5],
),20);
)

(
~door = Pbind(\instrument, \gplay2, \buf, d["g"][1], \d,Pwhite(1,100)/10000, \start,Pwhite(0,50)/100, \end,Pwhite(50,100)/100, \dur, l/4, \rate, Pwhite(-10,10)/10, \amp, 0.1, \restart, Pkey(\start), \trig,Pbjorklund(3,8)/4);
~door.play;
)

p.fadeTime=10;

~door.stop(20);

~doorL = {RHPF.ar(~door.ar, LFNoise1.kr(0.1).range(100, 1000).round(50),0.005)};
~doorL.play;

~doorL.stop(40);

(
~dr = Pbind(\instrument, \gplay2, \buf, d["g"][2], \d,Pwhite(1,75)/100, \start,Pwhite(0,25)/100, \end,Pwhite(75,100)/100, \dur, l*2, \rate, Pwhite(1,20)/10, \amp, 0.2, \restart, 0, \trig,Pbjorklund(5,8));
~dr.play
)

~drF = {DFM1.ar(Mix.ar([~dr.ar]), LFNoise1.kr(0.1).range(60,1000), LFNoise1.kr(0.2).range(0.001, 0.95), 1,mul:0.6)};
~drF.play;

(
~k = Pbind(\instrument, \bplay, \buf, d["g"][2], \dur,Prand([2,0.5,0.25,0.25],inf), \amp,1, \rate, Pwhite(5,20)/10);
~k.play;
)


(
~sin = {Ringz.ar(SinOsc.ar(LFNoise1.kr(0.1).exprange(80,160)),LFNoise1.kr(0.2).range(100,200),0.3,1.01)};
~gsin = {GrainIn.ar(2, Dust.kr(LFNoise1.kr(0.3).range(2,10)),LFNoise1.kr(0.7).range(0.001,0.01),~sin.ar,LFNoise0.kr(0.1).range(-1,1))};
~gsin.play;
)

(
~saw = {Ringz.ar(VarSaw.ar(LFNoise1.kr(0.1).exprange(80,160)),LFNoise1.kr(0.2).range(100,200),0.3,1.01)};
~gsaw = {GrainIn.ar(2, Dust.kr(LFNoise1.kr(0.1).range(2,5)),LFNoise1.kr(0.3).range(0.001,0.01),~sin.ar,LFNoise0.kr(0.1).range(-1,1))};
~gsaw.play;
)

~door.stop(20);
~drF.stop(5);
~k.stop(10);

~gsin.stop(10)

~gsaw.stop(20);
~gsin.stop(20);

(
~pulse = {RLPF.ar(Pulse.ar([60,60.1], LFNoise1.kr(0.1).range(0.1,1)), LFNoise2.kr(0.05).range(300, 2000), LFNoise1.kr(0.2).range(0.001, 0.1),0.4)};
~pulse.play;
)

(
~pulse2 = {RLPF.ar(Pulse.ar([80,80.05], LFNoise1.kr(0.1).range(0.1,1)), LFNoise2.kr(0.09).range(200, 1200), LFNoise1.kr(0.2).range(0.0001, 0.01),0.4)};
~pulse2.play;
)

(
~del = {CombC.ar(DFM1.ar(Mix.ar([~pulse.ar,~pulse2.ar]),LFNoise1.kr(0.01).range(80,3000),LFNoise1.kr(0.1).range(0.1, 0.8),0.8),0.3, LFNoise1.kr(0.1).range(0.1,0.4),mul:0.8)};
~del.play;
)

~pulse.stop


~del.stop(40)

p.clear;
p.free;
p.pop