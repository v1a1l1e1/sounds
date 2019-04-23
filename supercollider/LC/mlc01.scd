"Setup/Setup.scd".loadRelative;

p.fadeTime = 3;

~k = Pbind(\instrument, \gplay1, \buf, d["k"][1], \dur, Prand([1,Pbjorklund2(Pwrand([3,5,4],[0.4,0.4,0.2],inf),8)/4],inf), \rate, Pwhite(0.7,1.4), \amp, 0.5);
~k.play;

~k2 = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Prand([0.5,Pbjorklund2(Pwrand([3,5,4],[0.4,0.4,0.2],inf),8)/4],inf), \rate, Pwhite(0.2,1.1), \amp, 0.3);
~k2.stop(10);

~hh = Pbind(\instrument, \gplay2, \buf, d["ch"][0], \dur, Pwrand([Pseq([0.5, Pseq([1],inf)],inf),Pbjorklund2(3,8)/4],[0.85, 0.15],inf), \rate, Pwhite(0.4,1.5), \amp, 0.3);
~hh.play;

~hh2 = Pbind(\instrument, \gplay2, \buf, d["ch"][1], \dur, Pwrand([Pseq([0.5, Pseq([1],inf)],inf),Pbjorklund2(3,8)/4],[0.85, 0.15],inf), \rate, Pwhite(0.8,1.8), \amp, 0.3);
~hh2.stop(20);

~oh = Pbind(\instrument, \gplay2, \buf, d["oh"][1], \dur, Pwrand([Pseq([0.5, 1],inf), 0.25],[0.9,0.1],inf), \amp, 0.3);
~oh.stop(30);

~sk = Pbind(\instrument, \gplay2, \buf, d["sk"][0], \dur, 4, \amp, 0.5);
~sk.play;

~synth = Pbind(\instrument, \synth, \scale, Scale.minor, \octave, Prand([3,4],inf), \degree, Prand([2,4,5,7,[2,5,4],[4,7,9]],inf), \amp, 0.6);
~synth.stop(20);

~bass = Pbind(\instrument, \bass, \freq, Prand([80,60],inf), \amp, 1, \dur, 2);
~bass.stop(10);

/* ------------ */

~sine = {SinOsc.ar([120,120.1],0,0.5)};
~pulse = {Pulse.ar([80,80.3],LFNoise0.kr(0.1).range(0.1,0.6),0.5)};

~sig = {~sine.ar * ~pulse.ar};
~sig.stop;

~flt = {RLPF.ar(~sig.ar, LFNoise1.kr(0.2).range(100,400), SinOsc.kr(0.1).range(0.1,0.5),1.1)};

~mod = {~flt.ar * ~k.ar};
~mod.stop(10);
	