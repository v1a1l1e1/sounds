
(
SynthDef(\pad,{|out=0, carfreq=100, modfreq=20, atk=0.5, sus=1, rel=1.5|
	var sig;
	sig = PMOsc.ar(
		[carfreq, carfreq*3/2, rrand(carfreq, carfreq*2).round(carfreq/2),carfreq/3],
		[modfreq, modfreq/2,modfreq*2/3, modfreq*2],
		[0, 1, 10,0]
	);
	sig = Resonz.ar(sig, carfreq*3/4, 0.5);
	Out.ar(out, sig * EnvGen.kr(Env([0,1,1,0],[atk,sus,rel]),doneAction:2));

}).add;
)
s.meter;
Synth(\pad);\