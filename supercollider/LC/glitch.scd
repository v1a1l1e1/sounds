("Setup/Setup.scd").loadRelative

(
~g1 = Pbind(\instrument, \bplaym, \buf, d["g"][0], \dur, Pbjorklund(3,8)/2, \rate, Pwhite(0.5,3), \amp, 0.2);
~g1.play;
~g2 = Pbind(\instrument, \bplay, \buf, d["g"][1], \dur, Pbjorklund2(3,8)/4, \rate, Pwhite(0.6, 2.5), \amp, 0.2);
~g2.play;
~g3 = Pbind(\instrument, \bplay, \buf, d["g"][2], \dur, Pbjorklund2(5,8)/4, \rate, Pwhite(0.2, 5), \amp, 0.2);
~g3.play;
)

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur,Pwrand([1, Pseq([0.5,0.25],4),Pbjorklund2(Pseq([3,5],4),8, 4)/4], [0.45, 0.35, 0.2],inf), \amp, 1.01, \rate, Pwhite(0.8,1.3));
~k.play;

~k2 = Pbind(\instrument, \bplaym, \buf, d["k"][1], \dur,Pwrand([0.5, Pseq([0.5,0.25],4),Pbjorklund2(Pseq([3,5],4),8,3)/4], [0.6, 0.2, 0.2],inf), \amp, 1.01, \rate, Pwhite(0.8,1.1));
~k2.play;
)
(
~sk = Pbind(\instrument, \bplay, \buf, d["sk"][0], \amp, 1.5, \dur,4,\rate,Pwhite(0.7,1.5));
~sk.play;
)

(
~b1 = Pbind(\instrument, \ring1, \dur,Pseq([0.5, Pseq([0.25],inf)],inf), \amp, 0.6, \f, Pkey(\freq),\scale, Scale.minor, \root, 0, \octave, Prand([2,-2],inf), \a, Pwhite(4,20), \d, Pwhite(0.85,1), \degree, Pif(Pfunc{0.3.coin},Prand([Pseq([2,4,7,0],inf).stutter(2),Pseq([4,5,2,3],inf).stutter(2),Pseq([6,4,2,0],inf).stutter(2)],inf),Pseq([5,3,2,7,4],inf).stutter(2), Pseq([2,4,7,0],inf).stutter(2)));
~b1.play;

~b2 = Pbind(\instrument, \ring1, \dur,Pseq([1, Pseq([0.25],inf)],inf), \amp, 0.6, \f, Pkey(\freq),\scale, Scale.minor, \root, 0, \octave, Prand([0,1,-2],inf), \a, Pwhite(6,20), \d, Pwhite(0.9,1), \degree, Pif(Pfunc{0.3.coin},Prand([Pseq([2,4,7,0].reverse,inf).stutter(2),Pseq([4,5,2,3].reverse,inf).stutter(2),Pseq([6,4,2,0].reverse,inf).stutter(2)],inf),Pseq([5,3,2,7,4].reverse,inf).stutter(2), Pseq([2,4,7,0].reverse,inf).stutter(2)));
~b2.play;
)

(
~r = {60};
~synth = Pbind(\instrument, \sinfb, \freq, Pwrand([Pseq((1..2).round(0.25),inf),Pseq((1..4).round(0.25),inf)],[0.9, 0.1],inf)*Pkr(~r), \amp, 0.2, \dur, Pbjorklund(3,8)/16, \fb, Pseq((6..11)/10,inf));
~synth.play;
~synth2 = Pbind(\instrument, \sinfb, \freq, Pwrand([Pseq((1..2).round(0.25),inf),Pseq((1..3).round(0.25),inf)],[0.9, 0.1],inf)*Pkr(~r), \amp, 0.1, \dur, Pbjorklund(3,8,inf,4)/16, \fb, Pseq((6..11)/10,inf));
~synth2.play;
)

~synth.stop(20); ~synth2.stop(20);
~b1.play;~b2.play;


p.fadeTime=5;


~b1.stop;

~k.play;~k2.play;
~g1.play();
~g2.play();
~g3.play();
