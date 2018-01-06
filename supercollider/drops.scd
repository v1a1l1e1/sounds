(
SynthDef(\drops, {|freq_min=50, freq_max=6000, density=1, decay=0.1|
	var sig = sum({SinOsc.ar({rrand(freq_min, freq_max)}!2,pi,2*Decay.ar(Dust2.ar(density),decay))}.tanh!7);
	Out.ar(0, Limiter.ar(sig, 0.8));
}).add
)

y = Synth(\drops, [\density, 0.5, \decay, 0.01, \freq_min, 200]);
x = Synth(\drops,[\density, 0.5,\decay, 0.02, \freq_max, 400]);

//rain???


s.plotTree;
s.meter;