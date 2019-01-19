("Setup/Setup.scd").loadRelative;

p.fadeTime=5;

j = Pwrand([1, Pbjorklund2(3,8,2)/4], [0.9, 0.1],inf);

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur, j, \rate, Pwhite(1,1.6), \amp, 1.3);
~k.play;
)

(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~oh.play;
)

(
~sn = Pbind(\instrument, \bplay, \buf, d["s"][0], \dur, Pseq([0.75, 0.5],inf), \rate, Pwhite(0.8,1.3), \amp, 0.5);
~sn.play;
)

(
~ring = Pbind(\instrument, \ring1, \f, Pkey(\freq), \octave, Prand([2,0,-2],inf), \degree, Pseq([2,4,5,7,0],inf), \a, Pwhite(0.1, 10), \d, Pwhite(0.2, 1), \root, 0, \dur, 0.25, \amp, 1);
~ring.play;

~ring2 = Pbind(\instrument, \ring1, \f, Pkey(\freq), \octave, Prand([2,2],inf), \degree, Pseq([2,4,5,7,0].reverse,inf), \a, Pwhite(0.2, 20), \d, Pwhite(0.5, 1), \root, 0, \dur, 0.25, \amp, 1);
~ring2.play;

~ring3 = Pbind(\instrument, \ring1, \f, Pkey(\freq), \octave, Prand([0,-2],inf), \degree, Pseq([2,4,5,7,0].scramble,inf), \a, Pwhite(0.1, 10), \d, Pwhite(0.2, 1.5), \root, 0, \dur, 0.25, \amp, 1);
~ring3.play;
)

~saw = {RLPF.ar(LFSaw.ar([LFSaw.kr(0.1).range(80,200).round(40), LFSaw.kr(0.101).range(80,200).round(40)],0,0.3), SinOsc.kr(0.1).range(500, 2000), SinOsc.kr(0.1).range(0.001, 0.1))};
~saw.stop;

~ring.stop;
~ring2.stop;
~ring3.stop;


~sawD = {CombC.ar(~saw.ar, 1, LFNoise1.kr(0.1).range(0.1, 0.5), 5)};
~sawD.stop(30);