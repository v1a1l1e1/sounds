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
~clang1 = Pbind(
	\instrument, \clang,
	\dur, 0.5,
	\freq, Pdefn(\freq),
	\amp, Pxrand([0.5, 0.2, 0.4]*0.125, inf),
	\phase, Pseq([pi/2, 0, pi/3], inf),
	\atk, 0.01,
	\sus, Prand([0.5,0.2, 0.8],inf),
	\rel, 0.01
);
~clang2 = Pbind(
	\instrument, \clang,
	\dur, 1,
	\freq, Pdefn(\bass),
	\amp, Pxrand([0.5, 0.2, 0.4]*0.125, inf),
	\phase, Pseq([pi, 0], inf),
	\atk, 0.001,
	\sus, Prand([0.5,0.2, 0.8],inf),
	\rel, 0.01
);
)

(
Pdefn(\freq, Pseq([
	Pxrand([[60, 63, 67],[63, 65, 68],[67, 72, 65],[60, 63, 65], [60,57,63]].midicps, 8),
	Pxrand([[67,69,72],[70, 73, 75],[65, 69, 73],[62, 64, 68]].midicps, 5),

],inf));
Pdefn(\bass, Pseq([[55, 53, 57],[50, 47, 52],[55, 57, 59]],inf));
)

(
~clang1.play;
~clang2.play;
)

p.clean;
p.pop;
currentEnvironment.clear;
p.clear;


