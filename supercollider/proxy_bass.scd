(
p = ProxySpace.new(s, "live");
p.push;
p.makeTempoClock;
p.clock.tempo = 2;
)

(SynthDef(\bass,{|out=0, atk=0.2, sus=0.5, rel=0.2, freq1=65, freq2=65.2, amp=1, rq_ls=0.8, rq_bp=0.5, fc_bp=60, fc_ls=50|
	var sig;
	sig = Saw.ar([freq1, freq2]);
	sig = Resonz.ar(BLowShelf.ar(BPF.ar(sig, fc_bp, rq_ls), 70, rq_bp), fc_ls, 0.2);
	sig = sig * EnvGen.kr(Env.new([0, 1, 1, 0], [atk, sus, rel]), 2, doneAction:2);
	Out.ar(out, sig*amp);
}).add;
SynthDef(\pad,{|out=0, fr=100, m_freq=20, index=0, m_phase=0, atk=0.1, sus=1, rel=2|
	var sig;
	sig = PMOsc.ar(fr!2, m_freq, index, m_phase);
	sig = sig * EnvGen.kr(Env.new([0, 1, 1,0],[atk, sus, rel]), doneAction:2);
	Out.ar(out, sig);
}).add;

)
s.meter;
Synth(\pad);

(
p.clock.tempo=(110/60);

~bass = Pbind(
	\instrument, \bass,
	\dur, Pbjorklund(5,8),
	\freq1, 65,//Pseq((Scale.major.degrees+35).midicps ,inf),
	\freq2, Pkey(\freq1),//+Pwhite((-0.2),0.2, inf),
	\sus, 0.15,
	\atk, 0.05,
	\rel, Pkey(\atk),
	\amp, 5,
	\rq_ls, 0.05,
	\rq_bp, 0.001,
	\fc_bp, Pseq([100,110, 90],inf),
	\fc_ls, Pxrand([70, 50, 65],inf),
);

~pad = Pbind(
	\instrument, \bass,
	\dur, Pbjorklund(3,8)*2,
	\freq1, Pxrand([[60, 63, 67, 69],[63, 69, 71],[60,65,68],[60, 63, 65, 67, 70]].midicps, inf),
	\freq2, Pkey(\freq1),//+Pwhite((-0.2),0.2, inf),
	\sus, 0.5,
	\atk, 0.7,
	\rel, 0.8,
	\amp, 0.3,
	\rq_ls, 0.9,
	\rq_bp, 1,
	\fc_bp, Pseq([500],inf),
	\fc_ls, Pxrand([1500],inf),
);
)
(
~bass.play;
~pad.play;
)
~bass.stop;