p = ProxySpace.push;

~b.play;

~a = {Lag.ar(LFClipNoise.ar(2!2, 0.5,0.5), 0.2)};

(
~b = {
	var c, d;
	c = Dust.ar(20!2);
	d = Decay2.ar(c, 0.01, 0.02, SinOsc.ar(11300));
	d + BPF.ar(c * 5, ~a.ar * 3000 + 1000, 0.1);
}
);

/* --- Refactoring --- */
(
~a = {
	var a;
	a = Lag.ar(LFClipNoise.ar(2!2, 0.5, 0.5), 0.2);
	BPF.ar(~c.ar * 5, a * 3000 + 1000, 0.1)
}
);

~c={Dust.ar(20!2)};
~d={Decay2.ar(~c.ar, 0.15, 0.2, SinOsc.ar(11300))};
~b= ~a + ~d;

/* --- self reference as control rate loop --- */

~out.play;
~x = 0.2;
~y = 1.1;
~w = 0.13;
~x = (~y * ~x) + ~w % 1.0;
~out = {Pan2.ar(SinOsc.ar(~x * 4000 + 200) * 0.1, ~x)};

/* --- parameters --- */
~out.clear;
~out.play;
(
~out = {|freq=440, mod = 0.4, detune = 0.1, a_in = #[1,1]|
	freq = freq * ([0, detune] + 1);
	LFTri.ar(LFTri.ar(mod * freq).range(freq * mod, freq)) * a_in * 0.2
}
);

(
~mod2 = {LFNoise1.kr(1).range(0,1)};
~mod1 = {LFPulse.kr(~mod2.kr * 30 +1, 0, 0.3)};
~freq1 = {~mod1.kr * 13100 + 100};
~freq2 = {LFTri.kr(30) * 200 + 300};
~audio1 = {BrownNoise.ar(LFClipNoise.kr(10.dup), 1)};
~audio2 = {SinOsc.ar(LFNoise2.kr(1.dup).exprange(4,1000))};
);

~out.map(\freq, ~freq2, \mod, ~mod1);
~out.set(\detune, 0.01);
~out.map(\freq, ~freq1, \mod, ~mod1);
~out.xmap(\freq, ~freq1, \mod, ~mod2);
~out.xmap(\freq, ~freq2, \mod, ~mod1, \a_in, ~audio2);
~out.map(\a_in, ~audio1);