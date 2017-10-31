(
SynthDef(\_01, {|out=0, freq=300, width=0.5, pulse_freq=1, amp=0.5|
	var sig,env;
	sig = VarSaw.ar({freq}!2, 0, width, 0.5);
	env = Linen.kr(Impulse.kr(pulse_freq), doneAction:2);
	sig = sig*amp*env;
	Out.ar(out, sig);
}).add;)

x = Synth(\_01);
x.set(\pulse_freq, 1, \width, 0.8);

(
~zero_one = Pbind(
	\instrument, \_01,
	\degree, Pseq((0..12).scramble, inf),
	\dur, 1,
	\width, Pseq([0.5, 0.8],inf),
	\pulse_freq, Prand([1, 2, 1.5, 0.5, 0.75],inf),
	\amp, Pseq([0.2, 0.1],inf),
);
)

~zero_one.play;

s.meter;
s.plotTree;