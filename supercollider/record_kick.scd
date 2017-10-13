
(
x = SynthDef.new(\kick,
	{
		arg freq=60, mix = 0.2, room=0.1;
		var sig, env_sig, env_freq, amp=0.5;
		env_freq = EnvGen.kr(Env.perc(0.001,0.2,2.5));
		sig = SinOsc.ar(60!2*env_freq, pi*LFNoise0.kr(2).range(0.25,0.5));
		env_sig = EnvGen.kr(Env.perc(0.001, 0.5, curve:-1), doneAction:0);
		sig = sig*amp*env_sig;
		sig = BPF.ar(sig, 60, 2.5);
		sig = FreeVerb.ar(sig, 0.2, 0.1);
		Out.ar(0, sig);
		DetectSilence.ar(sig, doneAction:2);
	}
).add;
)

s.prepareForRecord;


(
s.bind
({
	Pdef(\drum,
		Pbind(
			\instrument, \kick,
			\freq, Pseq([60], inf),
			\stretch, 2.1818181818181818, //(60/BPM)*4 = length of 1 bar @ BPM (measure 4/4)
			//\dur, Pdefn(\rythm)
			\dur, Pseq([1/2], inf),
		)
	).play(quant:2.1818181818181818);
	s.record;
});
)

s.stopRecording;