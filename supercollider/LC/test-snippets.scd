("Setup/Setup.scd").loadRelative;

(
Ndef(\gendy_glitch,{
	var n;
	n=10;
	Resonz.ar(
		Mix.fill(n,{
			var freq, numcps;
			freq= rrand(50,560.3);
			numcps= rrand(2,20);
			Pan2.ar(Gendy3.ar(
				6.rand,
				6.rand,
				1.0.rand,
				1.0.rand,
				freq,
				1.0.rand,
				1.0.rand,
				numcps,
				SinOsc.kr(exprand(0.02,0.2),0, numcps/2, numcps/2),
				0.5/(n.sqrt)
			), 1.0.rand2)
		}),
		Lag.kr(LFNoise0.kr(1).range(100,2000),0.5),
		Lag.kr(LFNoise0.kr(1).range(0.01,1),0.25),0.3)

});
)

Ndef(\gendy_glitch).play;

~k = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pbjorklund2(Prand([3,5,2,4],inf),Prand([8,7,11,13],inf))/4, \amp, 0.5);
~k.stop;

~fx_send = {Mix.ar([~k.ar])};
~rev = {CombC.ar(FreeVerb.ar(Mix.ar([~fx_send.ar]),0.8,0.7),0.3,0.2,0.1)};
~rev.play;