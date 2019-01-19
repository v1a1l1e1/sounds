("Setup/Setup.scd").loadRelative;

~vsaw1 = {VarSaw.ar([80,81], LFNoise1.kr(0.1).range(-pi,pi), LFNoise1.kr(0.1).range(0.5, 1),0.5)}
~vsaw1.play;
~vsaw2 = {VarSaw.ar([60,61], LFNoise1.kr(0.1).range(-pi,pi), LFNoise1.kr(0.1).range(0.5, 1.5),0.5)}
~vsaw2.play;

(
~vsaw = {~vsaw1.ar + ~vsaw2.ar};
~vsawEnv = {EnvGen.ar(Env.linen(0.1))};
~saw = {~vsaw.ar * ~vsawEnv.ar};
)

(
~pulse = {Pulse.ar([2,2.5], LFNoise1.kr(0.1).range(0.001,0.4))};
~pulseD = {RLPF.ar(CombC.ar(~pulse.ar, 1, LFNoise1.kr(0.1).range(0.5, 1), LFNoise1.kr(0.1).range(5,7),1), LFNoise1.kr(0.1).range(200, 1000).round(2), LFNoise1.kr(0.1).range(0.01, 0.1),0.5)};
~pulseD.play;
)

(
~vsawF = {RHPF.ar(~vsaw.ar, LFNoise1.kr(0.1).range(200, 800), LFNoise1.kr(0.1).range(0.05, 0.5),0.5)};
~vsaw.play;
)

~sin = {SinOscFB.ar([100,100.1], LFNoise1.kr(0.1).range(0.3, 0.7), 0.5)};
~sin.play;

~delay = {CombC.ar([~pulse, ~vsaw, ~sin], 0.5, LFNoise1.kr(0.1).range(0.1,0.5), 3)};
~delay.play;

~fb_delay = {CombC.ar([~vsawEnv, ~delay], 0.7, LFNoise1.kr(0.1).range(0.3, 0.8), 4 )};
~fb_delay.play;

(
~sn = Pbind(\instrument, \bplay, \buf, d["s"][0], \dur, Pbjorklund2(3,8), \amp, 1);
~sn2 = Pbind(\instrument, \bplay, \buf, d["s"][1], \dur, Pseq([0.5, Pseq([4],inf)],inf), \amp, 1);
~sn.play;
~sn2.play;
)

~fb_delay.stop(10);
~delay.stop(10);
~saw.stop(10);
~vsaw.stop(10);

(
~k = Pbind(\instrument, \bplay, \buf, d["sk"][0], \dur, Pbjorklund2(Pwrand([3,5],[0.75,0.25],inf),8)/4, \rate, Pwhite(1,3), \amp, 1);
~k.play;
)

~pulse.stop(10);
~pulseD.stop(10);

(
~flt = {DFM1.ar(~sin.ar, LFNoise1.kr(0.1).range(400, 600), 0.1)};
~flt.play;
~sin.stop(2);
)

~pulseD.play;

(
~fltD = {CombC.ar(~flt.ar, 1, LFNoise1.kr(0,1).range(0.1, 0.5), LFNoise1.kr(0.1).range(3,4))};
~fltD.play;
)
