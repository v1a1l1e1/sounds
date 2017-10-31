(
SynthDef(\pad,{|out=0, carfreq=100, modfreq=20, index=0, m_phase=0, atk=0.1, sus=0.5, rel=0.2, amp=1|
	var sig;
	sig = PMOsc.ar(carfreq!2, SinOsc.kr(modfreq).range(10, 30), index, m_phase);
	sig = sig * EnvGen.kr(Env.new([0, 1, 1,0],[atk, sus, rel]), doneAction:2);
	sig = Resonz.ar(sig, 200, 0.5);
	Out.ar(out, sig*amp);
}).add;
)

(
n = Scale.major.degrees;
Pbind(
	\instrument, \pad,
	\dur, 0.25,
	\carfreq, Prand([
		[n[0],n[2],n[4]],
		[n[0],n[4]],
		[n[2],n[4],n[5]],
		[n[0]],[n[1]],[n[2]],[n[3]],[n[4]],[n[5]],[n[6]],
		[n[3]],[n[1]],
]+((45 .. 55).choose).midicps,inf),
	//\carfreq, Prand([[75, 125], [60, 100], [120, 115]],inf),
	\amp, 0.05,
	\rel, 2,
	\atk, 3,
	\sus, 1,
).play;
)