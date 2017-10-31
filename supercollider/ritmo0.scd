("./Setup_samples.scd").loadRelative

/* ---------------- */

(
l = Prewrite(1, (
	1: [0.25, 2],
	0.25: [1, 0.65, 0.1, 0.3, 0.6, 0.1],
	0.1: [0.5, 1,2],
	2: [0.5, 0.75, 0.5,1]
),4);
)

s.meter;

(
~k = Pbind(\instrument, \player, \buf, d[\bd_][4], \dur, Pbjorklund2(4,8)/2, \amp, Pseq([0.8, 0.6], inf));
~k2 = Pbind(\instrument, \player, \buf, d[\bd_][1], \dur, Pbjorklund2(3,8)/2, \amp, Pseq([0.7,0.6], inf));
~sn = Pbind(\instrument, \player, \buf, d[\sd_][4], \dur, 2, \amp, Pwrand([0.6, 0.5], [0.99, 0.01],inf));
~hh = Pbind(\instrument, \player, \buf, d[\ch][0], \dur, 0.5, \amp, Pxrand([0.25, 0.55],inf));
~cl = Pbind(\instrument, \player, \buf, d[\cl][0], \dur, 0.5, \amp, 0.1);
~cl2 = Pbind(\instrument, \player, \buf, d[\cl][0], \dur, Pbjorklund2(3,8)/2, \amp, 0.5);
~oh = Pbind(\instrument, \player, \buf, d[\oh][0],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp, 0.1);
)



(
~k.play;
~sn.play;
)
~oh.play;
~k2.play;
~hh.play;

~cl.play;
~cl2.play;
)

s.quit;