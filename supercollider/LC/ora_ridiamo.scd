("Setup/Setup.scd").loadRelative

~b_d = Pseq([0, 2,4,7,5,4,5,3],inf);

(
~k1 = Pbind(\instrument,\bplay, \buf, d["k"][0], \amp, 2,\dur, Pwrand([1,Pbjorklund2(Pseq([3,8],2),8,2)/4],[0.8,0.2],inf), \rate, Pwhite(0.5,2));
~k1.play;
)
(
~k2 = Pbind(\instrument, \bplay, \buf, d["sk"][0], \dur, 4, \rate, Pwhite(1,1.5), \amp, 2);
~k2.play;
)

(
~k3 = Pbind(\instrument, \bplay, \buf, d["pk"][0], \dur, Pbjorklund2(3,8)/4, \rate, Pwhite(1,1.1), \amp, 2);
~k3.play;
)

(
~oh = Pbind(\instrument,\bplay,\sample, Prand([0,1],inf),\buf,Pindex(d["oh"],Pkey(\sample)),\dur,Pseq([0.5,Pwrand([Pseq([1],16), Pbjorklund2(5,8,2)],[0.9,0.1],inf)/2],inf),\amp,0.6);
~oh.play;
)

~oh.stop;

(
~sn = Pbind(\instrument, \vplay, \sample, 4, \buf, Pindex(d["s"], Pkey(\sample),inf), \dur, Pbjorklund2(3,8)/4, \rate, Pwhite(0.5,1), \amp, 0.6, \pos, Pseq((0..100).scramble/100, inf), \rel, 0.05);
~sn.play;
)


(
~b1 = Pbind(\instrument, \ring1, \f, Pkey(\freq), \scale, Scale.minor, \root, 0, \octave, Prand([0,2,3],inf), \degree, Pseq([0,2,4,7,5,4,5,3],inf), \dur, 0.25, \amp, 0.4, \a, Pwhite(4,20), \d, Pwhite(0.5, 0.95));
~b1.play;
)
(
~b2 = Pbind(\instrument, \ring1, \f, Pkey(\freq), \scale, Scale.minor, \root, 0, \octave, Prand([2,-2, -3],inf), \degree, Pseq([0,2,4,7,5,4,5,3].stutter(2),inf), \dur, Pseq([0.25,Pseq([0.25],inf)],inf), \amp, 0.4, \a, Pwhite(10,20), \d, Pwhite(0.2, 1));
~b2.play;
)

(
~b2r = Pbind(\instrument, \ring1, \f,Pkey(\freq)*2, \scale, Scale.minor, \root, 0, \octave, Prand([2,0],inf), \degree, Pstutter(2,Pseq([0,2,4,7,5,4,5,3].reverse),inf), \dur, 0.25, \amp, 0.4, \a, Pwhite(5,10), \d, [0.3,1]);
~b2r.play;
)


(
~b1_s = Pbind(\instrument, \ring1, \f, 100, \dur, 0.25, \amp, 0.4);
~b1_s.play;
)

(
~b2_s = Pbind(\instrument, \ring1, \f, Prand((40..90).round(15),inf), \dur, 0.5, \amp, 0.4);
~b2_s.play;
)

(
~b2r_s = Pbind(\instrument, \ring1, \f, Prand((80..120).round(45),inf),\dur, 0.5, \amp, 0.4, \a, Pwhite(5,10));
~b2r_s.play;
)

(
~syn = Pbind(\instrument, \ring1, \f, Prand((60..80).round(15),inf), \scale, Scale.minor, \octave, 0, \root, 0, \a, Pwhite(10, 20), \d, Pwhite(0.5,1.1), \dur, 0.25,\amp,1);
~syn.play;
)

~f = {80};

(
~fb = Pbind(\instrument, \sinfb, \freq, Pseq((10..30),inf)*Pkr(~f),\dur, Pbjorklund2(3,8)/16, \amp, 0.7, \fb, Pwrand([0.7, 0.8, 0.95, 1.1, 1.5], [0.4,0.25,0.25,0.06, 0.04],inf));
~fb.play;
)
~fb.stop;

(
~syn.stop(10);
~b1.play;
~b2.play;
~b2r.play;
)

(
~b1.stop(10);
~b2.stop(15);
~b2r.stop(5);
~syn.play;
)

(
~b1_s.stop(3);
~b2_s.stop(3);
~b2r_s.stop(3);
~b1.play;
~b2.play;
~b2r.play;
)

(
~b1.stop(10);
~b2.stop(15);
~b2r.stop(5);
~b1_s.play;
~b2_s.play;
~b2r_s.play;
)


