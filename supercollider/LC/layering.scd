("Setup/Steup.scd").loadRelative;

(
~k1 = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur, Pbjorklund2(3,8)/4,\amp,Pwrand([1,4],[0.95, 0.05],inf), \rate, Pseq([1,1.2],inf));
~k1.play;

~k2 = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur, Pbjorklund2(3,8)/4, \amp, 1, \rate, Pseq([1,1.8],inf));
~k2.play;
)

/*--- */
(
~t1 = Pbind(\instrument, \bplay, \buf, d["t"][0], \dur, Pseq([1,1,1,0.5],inf), \amp, 1);
~t2 = Pbind(\instrument, \bplay, \buf, d["t"][1], \dur, Pseq([1,1,1,0.25],inf), \amp, 1);
~t3 = Pbind(\instrument, \bplay, \buf, d["t"][2], \dur, Pseq([1,1,1,0.75],inf), \amp, 1);
~t1.play;~t2.play;~t3.play;
)

~k1.stop;~k2.stop;

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur, Pwrand([1,Pbjorklund(3,8)], [0.8, 0.2],inf), \amp,1);
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~oh.play;
~k.play;

~c = Pbind (\instrument, \bplay, \buf, d["c"][0], \dur, 0.75, \amp,0.8);
~c2 = Pbind(\instrument, \bplay, \buf, d["c"][0], \dur, Pbjorklund2(3,8)/4, \amp, ~mod);
~c.play;
~c2.play;
)

~mod = {SinOsc.kr(0.2).range(0.5, 0.8)};

(
l = Prewrite(1,(
	1:[0.25,2],
	0.25:[1,0.75,0.1,0.3,0.6,0.1],
	0.1:[0.5, 1, 2],
	2:[0.5, 0.75,0.5,1]
),4);

~h = Pbind(\instrument, \bplay, \buf, d["ch"][0], \dur, l/2, \amp, 1, \rate, 2);
~c = Pbind(\instrument, \bplay, \buf, d["c"][0], \dur, l*2, \amp, 1);
~t = Pbind(\instrument, \bplay, \buf, d["t"][0], \dur, l, \amp, 1, \rate, Pseq([1.2, 1.4, 1.7],inf));
~sn = Pbind(\instrument, \bplay, \buf, d["s"][0], \dur, l*4, \amp, 1, \rate, 0.8);
~ding = Pbind(\instrument, \bplay, \buf, d["ding"][0], \dur, Pwhite(1,5), \amp, 1, \rate, 2);
~h.play;~c.play;~t.play;~sn.play;~ding.play;
)

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][2],\dur, 2, \amp, 4, \rate, 0.5 );
~k.play;
)

