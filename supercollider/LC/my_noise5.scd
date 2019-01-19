p.fadeTime = 5;

(
t = Prand([	Prand([Pseq([Pseq([2,4,7,5],4),Pseq([2,4,4,5],4),Pseq([2,5,7,7],4),Pseq([4,7,2,4],4)],2),Pseq([4,5,2,3],4),Pseq([6,4,2,0],4)],8),Pseq([Pseq([2,4,9],2),Pseq([5,7,2],4),Pseq([5,4],1),Pseq([2,7],1)],4),Pseq([Prand([Pseq([1,7,5],2),Pseq([2,5,9],2),Pseq([4,2,2],1),Pseq([9,7,3],1)],3),Prand([Prand([2,4,5],2),Prand([7,9,1],1),Pseq([2,4,5,7],2)],4),Prand([Pseq([3,5],2),Pseq([5,7,9],1),Prand((1..10),1)],2)],8)],inf);

f = Prand([Pseq([5,3,2,7,4],2),Pseq([2,5,8],2),Pseq([Pseq([3,7,9,5],3),Prand([2,5],1),Pseq([4,5,2,7],1),],4)],inf);
)

~vsaw = {Pan2.ar(VarSaw.ar([80,81], LFNoise1.kr(0.1).range(-pi,pi), LFNoise1.kr(0.1).range(0.1, 1)),0,SinOsc.kr(0.1).range(-1,1))}
~vsaw.play;

~pulse = {Pan2.ar(Pulse.ar([2,1.5], LFNoise1.kr(0.1).range(0.001,0.4)),SinOsc.kr(0.1).range(-1,1))};

(
~synth1 = {~vsaw.ar * ~pulse.ar*0.9};
~synth1.stop(20);
)
(
~pulseD = {RLPF.ar(CombC.ar(~pulse.ar, 1, LFNoise1.kr(0.1).range(0.5, 1), LFNoise1.kr(0.1).range(5,7),1), LFNoise1.kr(0.1).range(200, 1000), LFNoise1.kr(0.1).range(0.01, 0.1),0.1)};
~pulseD.play;
)

~flt = {DFM1.ar([~pulseD.ar], LFNoise1.kr(0.1).range(100, 3000), LFNoise1.kr(0.1).range(0.9,1.01), 0.8,0,0.003,0.9)};
~flt.play;
~flt.stop(10);

(
~r = {60};
~synth = Pbind(\instrument, \sinfb, \freq, Pwrand([Pseq((1..2).round(0.25),inf),Pseq((1..4).round(0.25),inf)],[0.9, 0.1],inf)*Pkr(~r), \amp, 0.1, \dur, Pbjorklund(3,8)/8, \fb, Pseq((6..11)/10,inf));
~synth.play;
~synth2 = Pbind(\instrument, \sinfb, \freq, Pwrand([Pseq((1..2).round(0.25),inf),Pseq((1..3).round(0.25),inf)],[0.9, 0.1],inf)*Pkr(~r)*1.5, \amp, 0.1, \dur, Pbjorklund(3,8,inf,4)/8, \fb, Pseq((6..11)/10,inf));
~synth2.play;
)

~noise = {WhiteNoise.ar(0.1)};

~noise = {RLPF.ar(~noise.ar,LFNoise1.kr(0.1).range(60,800),LFNoise1.kr(0.1).range(0.1,0.5),0.5)}
~noise.stop;

(
~synth2.stop(5)
~synth4 = Pbind(\instrument, \sinfb, \freq, Pwrand([Pseq((1..10)/2,inf), Pseq((1..18)/5, inf)], [0.6,0.4],inf)*Pkr(~r),\fb, Pwhite(0.3,0.93), \amp, 0.7, \dur, Pbjorklund(Prand([3,8,9],inf),Prand([8,16],inf)));
~synth4.play;
)

(
~synth3 = Pbind(\instrument, \sinfb, \freq, Pwrand([Pseq([0.5, 1],inf),Pseq((1..10)/4.round(3),inf), Pseq((1..8)/5.round(3), inf)], [0.6,0.2,0.2],inf)*Pkr(~r),\fb, Pwhite(0.3,1), \amp, 0.7, \dur, Pbjorklund(Prand([3,8,9],inf),Prand([8,16],inf)));
~synth3.play;
)

~synth3.stop(5);~synth4.stop(30);

(
~g1 = Pbind(\instrument, \bplaym, \buf, d["g"][0], \dur, Pbjorklund(3,8)/2, \rate, Pwhite(0.5,3), \amp, 0.4);
~g1.play;
~g2 = Pbind(\instrument, \bplay, \buf, d["g"][1], \dur, Pbjorklund2(3,8)/4, \rate, Pwhite(0.6, 2.5), \amp, 0.4);
~g2.play;
~g3 = Pbind(\instrument, \bplay, \buf, d["g"][2], \dur, Pbjorklund2(5,8)/4, \rate, Pwhite(0.2, 5), \amp, 0.4);
~g3.play;
~pulseD.stop(10);
)

~synth.stop(10); ~synth2.stop(10);

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur,Pwrand([1, Pseq([0.5,0.25],4),Pbjorklund2(Pseq([3,5],4),8, 4)/4], [0.45, 0.35, 0.2],inf), \amp, 1.9, \rate, Pwhite(0.8,1.3));
~k.play;

~k2 = Pbind(\instrument, \bplaym, \buf, d["k"][1], \dur,Pwrand([0.5, Pseq([0.5,0.25],4),Pbjorklund2(Pseq([3,5],4),8,3)/4], [0.6, 0.2, 0.2],inf), \amp, 1.9, \rate, Pwhite(0.8,1.1));
~k2.play;
)
(
~sk = Pbind(\instrument, \bplay, \buf, d["sk"][0], \amp, 1.9, \dur,Pwrand([Pseq([1],4),Pbjorklund2(3,8,1)],[0.9, 0.1],inf),\rate,Pwhite(0.7,1.5));
~sk.play;
)

~synth4.stop(20);
~synth3.stop(25);
~synth1.stop(20);
~synth2.stop(10);
~synth.stop(20)
~synth1.play;
~pulseD.stop(30)
~vsaw.stop(7)

(
~b1 = Pbind(\instrument, \ring1, \dur,Pseq([0.25, Pseq([0.25],inf)],inf), \amp, 0.6, \f, Pkey(\freq),\scale, Scale.minor, \root, 0, \octave, Prand([1,2,0],inf), \a, Pwhite(4,20), \d, Pwhite(0.85,1.5), \degree, Pif(Pfunc{0.3.coin},t,f));
~b1.play;

~b2 = Pbind(\instrument, \ring1, \dur,Pseq([1, Pseq([0.25],inf)],inf), \amp, 0.6, \f, Pkey(\freq),\scale, Scale.minor, \root, 0, \octave, Prand([1,2,3],inf), \a, Pwhite(6,20), \d, Pwhite(0.9,1.5), \degree,Pif(Pfunc({0.3.coin}),t,f));
~b2.play;
)

~b1.stop(10);
~b2.stop(15);
~vsaw.play;
~k.stop(5); ~k2.stop(10);
~g1.stop(10);~g2.stop(10);~g3.stop(10);
~sk.stop(20);
~synth1.stop(30);
~vsaw.stop(10);
~pulseD.stop(10);

p.clear()