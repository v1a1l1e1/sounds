(
SynthDef(\clang, {|out=0, freq=60, amp=0.5,phase=0, atk=0.01, sus=0.5, rel=0.01|
	var sig;
	sig=Klang.ar(`[[freq, freq/3*2, freq*4/3],[amp, amp/2, amp*0.8],[phase, phase+pi, phase+pi/2]])!2;
	sig = sig*EnvGen.kr(Env([0,1,1,0],[atk, sus, rel]), doneAction:2);
	Out.ar(out, sig*0.25);
}).add;
)

s.meter;

p=ProxySpace.push(s);
p.makeTempoClock(2);

(
~clang = Pbind(
	\instrument, \clang,
	\dur, 0.5,
	\freq, Pxrand([[60, 63, 67],[63, 65, 68],[67, 72, 65],[60, 63, 65], [60,57,63]].midicps, inf),
	\amp, Pxrand([0.5, 0.2, 0.4]*0.125, inf),
	\phase, Pseq([pi/2, 0, pi/3], inf),
	\atk, 0.01,
	\sus, Prand([0.5,0.2, 0.8],inf),
	\rel, 0.01
);
)

~clang.play;