"Setup/Setup.scd".loadRelative;

~k = Pbind(\instrument, \gplay2, \buf, d["k"][0], \rate, Pwhite(0.8,1.2), \dur, Pbjorklund2(Pseq([3,5,7],inf),8)/2, \amp, 0.25);
~k2 = Pbind(\instrument, \gplay1, \buf, d["k"][1], \rate, Pwhite(0.8,4), \dur, Pwrand([Pseq([0.5],4),Pbjorklund2(Pseq([5,3],8),8)/4],[0.2,0.8],inf), \amp, 0.25);

~k.play;~k2.play;

~g1 = Pbind(\instrument, \gplay1, \buf, d["g"][0], \rate, Pwhite(0.1,1.5), \dur, Pbjorklund2(Prand([3,5,7],inf),Prand([8,11],inf))/2,\amp, 0.2);
~g2 = Pbind(\instrument, \gplay1, \buf, d["g"][2], \rate, Pwhite(1.2,2.3), \dur, Pbjorklund2(Prand([3,5,7],inf),Prand([8,11],inf),0,Pwhite(1,6).round(1).asStream)/4,\amp, 0.2);

~g1.play;~g2.play;

~m = Pbind(\instrument, \mu, \scale, Scale.minor, \octave, Prand([2,3,4],inf),\degree, Prand((0..11),inf),\fb, Pwhite(0.1,0.6), \dur, Pseq([2,1],inf));
~m.play;

~synth = Pbind(\instrument, \synth, \scale, Scale.minor, \octave, Pseq([2,3],inf), \degree, Prand([[1,3,5],[2,4,6],[5,7,9]],inf), \amp, 1, \dur, Prand([2,4],inf));
~synth.play;

~sine = {SinOsc.ar(Scale.minor.degreeToFreq(0,40,1),0, 0.5)};
~pulse = {Pulse.ar(20,LFNoise1.kr(0.1).range(0.2,0.6),0.5)};
~sig = {~sine.ar*~pulse.ar};


~flt = {CombC.ar(~sig.ar, 0.1, 0.3, 3)};
~sc = {~flt.ar*~sk.ar};
~sc.play;

~gr = Pbind(\instrument, \tgrain, \in, d["g"][3], \fm, 10, \fM, 100, \d, 0.2, \r, Pwhite(0.1,3.5), \amp, 0.8);
~gr.play;

~o = Pbind(\instrument, \gplay2, \buf, d["oh"].choose, \rate, Pwhite(0.1, 2.5), \dur, Pwrand([Pseq([2,1],16),Pbjorklund2(Pseq([3,5,7],inf),8)],[0.1,0.9],inf), \amp, 0.3);
~o.play;

~bass = Pbind(\instrument, \bass, \scale, Scale.minor, \octave, 2, \degree, Pseq([0,3,5],inf),\amp, 0.7, \dur, Pseq([0.5, Pseq([4],inf)],inf));
~bass.play;

p.fadeTime=5;



~sk = Pbind(\instrument, \gplay2, \buf, d["sk"][0],\dur,4, \amp, 0.3);
~sk.play;