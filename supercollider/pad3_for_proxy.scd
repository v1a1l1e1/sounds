
(
SynthDef(\pad,{|out=0, carfreq=100, modfreq=20, atk=0.5, sus=1, rel=1.5, rq=0.5, amp=1|
	var sig;
	sig = PMOsc.ar(
		[carfreq, carfreq*3/2, rrand(carfreq, carfreq*2).round(carfreq/2),carfreq/3, carfreq+modfreq, LFNoise0.kr(carfreq).exprange(carfreq/2, carfreq*2)],
		[modfreq, modfreq/2,modfreq*2/3, modfreq*2],
		[0, 1, 10,0]
	);
	sig = Resonz.ar(sig, carfreq*3/4, rq, amp);
	Out.ar(out, sig * EnvGen.kr(Env([0,1,1,0],[atk,sus,rel]),doneAction:2));

}).add;
)
s.meter;

Pbindef(\pads, \instrument, \pad).play;
Pbindef(\pads, \carfreq, Pxrand([1b, 5, 3, 1b, 6, 2, 5, 0, 3, 0, 2],inf)+(30..60).choose.midicps);
Pbindef(\pads, \modfreq, Pxrand((5..50),inf));
Pbindef(\pads, \dur, rrand(0.1, 1.5).round(0.5));
Pbindef(\pads, \rq, 0.01, \amp, 5);
Pbindef(\pads, \atk, 4, \rel, 3, \sus, 1);
Pbindef(\pads).stop;

s.plotTree;