(
p = ProxySpace.new(s, "live");
p.push;
p.makeTempoClock;
p.clock.tempo = 2;
)
(
SynthDef(\prox, {|out=0, freq=220, fc_bp = 100, rq = 0.5, fc_ls = 10 ,gain=0|
	var sig = Saw.ar([freq, (freq+0.2)], 0.7) * EnvGen.kr(Env.perc(releaseTime:2), doneAction:2);
	sig = BPF.ar(sig, fc_bp, rq);
	sig = LowShelf.ar(sig, fc_ls, dbgain:gain);
	Out.ar(out, sig);
}).add;
)

(
p.clock.tempo = (110/60);
~pat = Pbind(\instrument, \prox,
	\dur, 1,
	//\dur, Pwrand([Pxrand([0.5, 0.75, 1],2), Pbjorklund(5,8,2)/2],[0.6, 0.4],inf),
	//\degree, Pxrand([0, 1, 2, 3,4, 5, 6, 7],inf),
	\freq, 60,
	\fc_bp, 100,
	\rq, 0.06,
	\fc_ls, 1000,
	\gain, 1,
);
)
~pat.play;