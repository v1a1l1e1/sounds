(
SynthDef(\fischietto,
	{|gate=1|
		var sig,env, in, in_amp, freq;
		in = LPF.ar( Amplitude.ar( SoundIn.ar(0) ), 10 );
		in_amp = in.range(0,127);
		freq = in*500+400;
		env = (in*in*127).poll(10);
		//env = EnvGen.kr(Env.asr(0,1,0.1),gate,doneAction:2);

		sig = StkInst.ar(Stk.at("Whistle"),freq, gate, 1, 0,
			[
			4,64,
			11,64,
			1, 1,
			2, in_amp,
			128, 127
			]
		)*0.25;
    Out.ar(0, sig.dup);
}).add;
)

x = Synth(\fischietto);
x.set(\gate, 0);

s.meter;
AudioIn.ar(0);