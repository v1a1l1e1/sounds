(
SynthDef(\comb, {|freq=1, vol=0.5, decay=0.2, max_delay=0.2, delay=0.2, mul=3|
	var freq1 = freq;
	var freq2 = freq+PinkNoise.kr(1).exprange(0.5, 1.5);
	var sig = CombN.ar(Decay.ar(Dust.ar([freq1, freq2], vol), decay, {WhiteNoise.ar}!2),max_delay, delay, mul);
	Out.ar(0, FreeVerb.ar(sig, 0.5, 0.2));
}).add;
)

c = Synth(\comb, [\freq, 10, \decay, 0.08, \max_delay, 1.5, \delay, 1,\mul, 1]);

