(
SynthDef(\bells, {|f1=800, f2=1071, f3=1153, f4=1723, amp=1|
	var sig, env;
	sig = Klank.ar(`[[f1, f2, f3, f4], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1));
	env = EnvGen.kr(Env.linen(0.01, 0.05, 0.4), doneAction:2);
	//sig = Resonz.ar(sig, [800, 1071, 1153, 1723], 0.001);
	sig = Pan2.ar(sig);
	Out.ar(0, sig*amp);
}).add;
)


x = { Synth(\bells)}!4;



{ Klank.ar(`[[800, 1071, 1153, 1723], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1)) }.play;

s.quit;