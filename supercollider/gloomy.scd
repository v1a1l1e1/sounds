(
SynthDef(\blob,{|freq=50, atk=0.5, sus=1, rel=0.5, out=0, amp=1, fc = 10, rq=0.01,pan=0|
	var sig = Saw.ar(freq,0.8);
	sig = sig * EnvGen.kr(Env.new([0, 1, 1, 0], [atk, sus, rel]), doneAction:2);
	sig = BPF.ar(sig, freq,0.1);
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(out, sig);
}).add
)

(
Pbind(
	\instrument, \blob,
	\freq, (Scale.major.degrees+30).midicps.choose,
	\dur, 0.5,
	\sus, Prand([1, 0.5, 0.75, 1.25], inf),
	\pan, Pwhite(-1, 1, inf),
	\amp, Pbjorklund(3, 16, inf),
).play;
)
