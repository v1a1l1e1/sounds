("Setup/Setup.scd").loadRelative;

p.fadeTime = 4;

Ndef(\Dust, {RHPF.ar(Dust.ar(LFNoise1.kr(2).range(2,20), 0.25), LFNoise1.kr(0.4).range(300,400), 0.01,2)});
Ndef(\Dust).stop;

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

~doorL = {RHPF.ar(~door.ar, LFNoise0.kr(0.1).range(100, 2000).round(50),0.005)};
~doorL.play;

(
~dr = Pbind(\instrument, \gplay2, \buf, d["g"][2], \d,Pwhite(1,75)/100, \start,Pwhite(0,25)/100, \end,Pwhite(75,100)/100, \dur, l*2, \rate, Pwhite(1,20)/10, \amp, 0.1, \restart, 0, \trig,Pbjorklund(5,8));
~dr.play
)

~drF = {DFM1.ar(Mix.ar([~dr.ar]), LFNoise1.kr(0.1).range(60,1000), LFNoise1.kr(0.2).range(0.001, 0.95), 1,mul:0.6)};
~drF.play;

(
~k = Pbind(\instrument, \bplay, \buf, d["g"][2], \dur,Prand([4,2,0.5],inf), \amp,1, \rate, Pwhite(5,20)/10);
~k.play;
)


(
~sin = {Ringz.ar(SinOsc.ar(LFNoise1.kr(0.1).exprange(80,160)),LFNoise1.kr(0.2).range(100,200),0.3,1.01)};
~gsin = {GrainIn.ar(1, Dust.kr(LFNoise1.kr(0.3).range(2,10)),LFNoise1.kr(0.7).range(0.001,0.01),~sin.ar)};
~gsin.play;
)

p.clear;
p.free;
p.pop