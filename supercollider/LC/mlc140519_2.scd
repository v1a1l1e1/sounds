"Setup/Setup.scd".loadRelative;

~k = Pbind(\instrument, \gplay2, \buf, d["k"][0], \rate, Pwhite(0.8,1.2), \dur, Pwrand([Pbjorklund2(Pseq([3,5,7],32),8)/2,Pseq([0.25,0.5],16)],[0.9,0.1],inf), \amp, 0.25);
~k2 = Pbind(\instrument, \gplay1, \buf, d["k"][1], \rate, Pwhite(0.8,4), \dur, Pwrand([Pseq([0.5,0.25],4),Pbjorklund2(Pseq([5,3],8),8)/4],[0.2,0.8],inf), \amp, 0.25);

~k.play;~k2.play;

~g1 = Pbind(\instrument, \gplay1, \buf, d["g"][0], \rate, Pwhite(0.1,1.5), \dur, Pbjorklund2(Prand([3,5,7],inf),Prand([8,11],inf))/4,\amp, 0.2);
~g2 = Pbind(\instrument, \gplay1, \buf, d["g"][2], \rate, Pwhite(1.2,2.3), \dur, Pbjorklund2(Prand([3,5,7],inf),Prand([8,11],inf),0,Pwhite(1,6).round(1).asStream)/4,\amp, 0.2);

~g1.play;~g2.play;

~m = Pbind(\instrument, \mu, \scale, Scale.minor, \octave, Prand([2,3,4],inf),\degree, Prand((0..11),inf),\fb, Pwhite(0.1,0.6), \dur, Pseq([2,1],inf));
~m.play;

~synth = Pbind(\instrument, \synth, \scale, Scale.minor, \octave, Prand([2,3],inf), \degree, Prand([1,3,5,2,4,6,5,7,9],inf), \amp, 0.8, \dur, Prand([0.25,0.5],inf));
~synth.play;

~sine = {SinOsc.ar(Scale.minor.degreeToFreq(0,40,1),0, 0.5)};
~pulse = {Pulse.ar(20,LFNoise1.kr(0.1).range(0.2,0.6),0.5)};
~sig = {~sine.ar*~pulse.ar};


~flt = {CombC.ar(~sig.ar, 0.1, 0.3, 3)};
~sc = {~flt.ar*~sk.ar};
~sc.play;

~gr = Pbind(\instrument, \tgrain, \in, d["g"][3], \fm, 10, \fM, 100, \d, 0.2, \r, Pwhite(0.1,3.5), \amp, 0.8);
~gr.stop(5);

~o = Pbind(\instrument, \gplay2, \buf, d["oh"].choose, \rate, Pwhite(0.1, 2.5), \dur, Pwrand([Pseq([2,1],16),Pbjorklund2(Pseq([3,5,7],inf),8)],[0.1,0.9],inf), \amp, 0.3);
~o2 = Pbind(\instrument, \gplay2, \buf, d["oh"][0], \rate, Pwhite(0.1, 4), \dur, Pwrand([Pseq([1,0.5],16),Pbjorklund2(Pseq([3,5,7],inf),8,Pwhite(1.7).round(1))/2],[0.1,0.9],inf), \amp, 0.2);
~o.play; ~o2.play;

~bass = Pbind(\instrument, \bass, \scale, Scale.minor, \octave, 2, \degree, Pseq([0,3,5],inf),\amp, 0.7, \dur, Pseq([0.5, Pseq([4],inf)],inf));
~bass.play;

p.fadeTime=5;



~sk = Pbind(\instrument, \gplay2, \buf, d["sk"][0],\dur,4, \amp, 0.3);
~sk.play;

~fgh = Pbind(\instrument, \fgh, \dur, 4, \amp, 0.4, \scale, Scale.minor, \octave, 2, \degree, Prand((0..11),inf));
~fgh.play;

~fgh.stop(20);
~bass.stop(10);
~synth.stop(10);
~o2.stop(10);
~o.stop(10);

~m.stop(20);
~gr.stop(2);

~g1.stop(30);
~k2.stop(20);
~k.stop(10);
~k2.stop(2);
~g2.stop(2);
~flt.stop(10);~sk.stop(10);