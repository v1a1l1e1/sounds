(
SynthDef(\gh, {|freq=200, freq2=75|
	var sig;
	sig = Pulse.ar({LFNoise1.kr(0.5).exprange(freq/2, freq*2)}!2, SinOsc.kr(0.5).exprange(0.4, 0.6));
	sig = BPF.ar(sig, freq/2, 0.005);
	sig = LowShelf.ar(sig,{LFNoise1.kr(0.5).exprange(freq2/2, freq2*2)}!2);
	Out.ar(0, sig);
}).add;
)

(
Pbind(
	\instrument, \gh,
	\dur, 1,
	\freq, Prand([100, 150, 75, 200],inf)
).play;
)


s.meter;
s.plotTree;