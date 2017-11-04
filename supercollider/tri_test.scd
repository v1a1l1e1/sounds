
(
SynthDef(\polvere,{|freq = 440|
	var sig, mod_sig, hz;
	hz = LFNoise0.kr(1).range(10, 20);
	mod_sig = Dust2.kr(hz!2);
	sig = SinOsc.ar(freq, mul: mod_sig);
	Out.ar(0, sig);
}).add;
)

(
SynthDef(\base, {|freq=220, width=0.5|
	var sig;
	sig = Pulse.ar(freq!2, width, 0.2);
	Out.ar(0, sig);
}).add;

)

~fx = Bus.audio(s, 2);

Synth(\polvere);
Synth(\base);