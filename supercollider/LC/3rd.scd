("Setup/Setup.scd").loadRelative;

p.fadeTime=5;

~f = {80};

(
~sinfb1 = Pbind(\instrument, \sinfb, \freq, Pseq([1,2,4,5,7,4,2,7,5],inf)*Pkr(~f), \dur, Pwrand([0.25, Pseq([0.5,0.25],4), Pbjorklund(Pseq([3,5]),8,2)],[0.8, 0.1,0.1],inf));
~sinfb1.play;
)
(
~sinfb2 = Pbind(\instrument, \sinfb, \freq, Pseq([1,2,4,5,7,4,2,7,5].reverse,inf)*Pkr(~f)*2, \dur, Pwrand([0.25, Pseq([0.5,0.25],4), Pbjorklund(Pseq([3,5]),8,2)],[0.8, 0.1,0.1],inf));
~sinfb2.play;
)
(
~sinfb3 = Pbind(\instrument, \sinfb, \freq, Pseq([1,2,4,5,7,4,2,7,5].scramble,inf)*Pkr(~f)*4, \dur, Pwrand([0.125, 0.25, Pseq([0.5,0.25],4), Pbjorklund(Pseq([3,5]),8,2)],[0.3,0.5, 0.1,0.1],inf));
~sinfb3.play;
)


(
~k = Pbind(\instrument, \bplaym, \buf, d["k"][0], \dur, 1, \amp, 1, \rate, Pwhite(0.5, 2));
~k.play;

~k2 = Pbind(\instrument, \bplay, \buf, d["k"][2], \dur, Pseq([0.5, Pseq([1],inf)],inf), \amp, 1, \rate, Pwhite(1,3));
~k2.play;
)



p.clear;