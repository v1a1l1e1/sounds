("Setup/Setup.scd").loadRelative;

p.fadeTime = 3;

(
~ring1 = Pbind(\instrument,\ring1,\dur, Pbjorklund2(Pseq([3,5],4),8,4)/4, \f, Pkey(\freq)*([1,0.5].choose).round(30), \a, Pwhite(4,10), \d,Pwhite(2,4), \amp, 0.4);
~ring1.play;
)

(
~ring2 = Pbind(\instrument,\ring1,\dur, Pwrand([1,0.5,Pbjorklund2(Pseq([5,3],4),8,4)/4],[0.6,0.3,0.1],inf), \f, Pwhite(50,300).round(30), \amp, 0.4,\a, Pwhite(4,10), \d,Pwhite(2,4));
~ring2.play;
)

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \amp, 0.7, \dur, Pwrand([1,Pbjorklund2(Pseq([3,8],2),8,2)/4], [0.9, 0.1],inf), \rate, Pwhite(0.8, 1.2));
~k.play;
)

(
~sn = Pbind(\instrument, \bplay, \buf, d["s"][0], \dur, 2, \rate, Pwhite(0.5,0.9));
~sn.play;
)

(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pwrand([0.5,Pseq([1],4),Pbjorklund2(3,8,4)/4],[0.45,0.45,0.1],inf),\amp,0.5);
~oh.play;
)

(
~sk = Pbind(\instrument, \bplay, \buf, d["sk"][0], \dur,4,\rate,Pwhite(0.9,1.1), \amp, 0.8);
~sk.play;
)

(
~ring3 = Pbind(\instrument,\ring1,\dur, Pwrand([1,0.5,0.25,Pbjorklund2(Pseq([5,3,11],4),8)/4],[0.5,0.3,0.15,0.05],inf), \f, Pwhite(30,60).round(15), \amp, 0.4,\a, Pwhite(4,10), \d,Pwhite(2,4));
~ring3.play;
)

(
~fx = Pbind(\instrument, \vplay, \buf, d["fx"][0], \amp,0.2, \dur, Pseq([0.5, Pseq([4],inf)],inf), \rate, Pwhite(0.2,1.1), \pos, Pseq((1..100)/100), \rel, 0.001);
~fx.play;

~fx1 = Pbind(\instrument, \vplay, \buf, d["fx"][1], \amp,0.2, \dur, Pseq([1, Pseq([2],inf)],inf), \rate, Pwhite(0.2,1.5), \pos, Pseq((1..100)/100), \rel, 0.001);
~fx1.play;

~fx2 = Pbind(\instrument, \vplay, \buf, d["fx"][2], \amp,0.2, \dur, Pseq([2.5, Pseq([8],inf)],inf), \rate, Pwhite(0.2,1.1), \pos, Pseq((1..100)/100), \rel, 0.001);
~fx2.play;
)


(
~g = Pbind(\instrument, \bplaym, \buf, d["g"][0], \dur, Pbjorklund2(3,8)/4, \amp, 0.4, \rate, Pwhite(0.1, 2));
~g.play;
)

(
~g2 = Pbind(\instrument, \bplay, \buf, d["g"][2], \dur, Pbjorklund2(Pseq([3,5],inf),Pseq([8,16],inf))/4, \amp, 0.4, \rate, Pwhite(0.5, 1.1));
~g2.play;
)

p.fadeTime=5;
~sn.stop(10);
~ring2.stop(20);
~ring1.stop(10)

~oh.stop(30)

~ring3.stop(40)

~k.stop(10); ~sk.stop(15);

~g.stop(10);~g2.stop(5);


~fx.stop(1);~f2.stop(1);~f3.stop(1);

p.clear;













