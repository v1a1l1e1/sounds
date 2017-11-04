(
SynthDef(\wah, {|freq=200, iphase=0, width=0.5, out=0, amp=1, pan_f=1|
	var sig;
	sig = VarSaw.ar(freq!2, iphase, width);
	sig = sig * EnvGen.kr(Env([0, 1, 1, 0], [1, 1, 3]), doneAction:2);
	Out.ar(out, Pan2.ar(sig*amp, SinOsc.kr(pan_f)));
}).add;

SynthDef(\clang, {|out=0, freq=60, amp=0.5,phase=0, atk=0.01, sus=0.5, rel=0.01|
	var sig;
	sig=Klang.ar(`[[freq, freq/3*2, freq*4/3],[amp, amp/2, amp*0.8],[phase, phase+pi, phase+pi/2]])!2;
	sig = sig*EnvGen.kr(Env([0,1,1,0],[atk, sus, rel]), doneAction:2);
	Out.ar(out, sig*0.25);
}).add;

)

s.meter

p=ProxySpace.push(s);
p.makeTempoClock(2);

(
~wah = Pbind(
	\instrument, \wah,
	\dur, 4,
	\iphase, Prand((0..2),inf)*pi,
	\freq, Pxrand((50..60), inf),
	\pan_f, (0.1, 0.15..7).choose,
);
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
~wah.play;