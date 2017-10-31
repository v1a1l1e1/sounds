("Setup_synths.scd").loadRelative

(
p.clock.tempo = 2;
(
~chords = Pbind(\instrument,\bpfsaw,
	\dur,Pwhite(4.5,7.0,inf),
	\midinote,Pxrand([
		[23,35,54,63,64],
		[45,52,54,59,61,64],
		[28,40,47,56,59,63],
		[42,52,57,61,63],
	],inf),
	\detune, Pexprand(0.0001,0.1,inf),
	\cfmin,100,
	\cfmax,1500,
	\rqmin,Pexprand(0.02,0.15,inf),
	\atk,Pwhite(2.0,4.5,inf),
	\rel,Pwhite(6.5,10.0,inf),
	\ldb,6,
	\amp,Pwhite(0.8,2.0),
	\out,0)
);
~chords.play;
)
//pulse them slightly with a low-passed kick
(
~k = Pbind(\instrument,\kick,\dur,Pbjorklund2(3,8)/2,\amp,2);
~lpfSend = {~k};
~lpf = {RLPF.ar(Mix.ar([~lpfSend]),SinOsc.kr(0.1).range(200,100),1)};
~lpf.play;
)

s.plotTree;
s.freeAll;