("Setup/Setup.scd").loadRelative;

(
p.clock.tempo=2;
~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur, Pbjorklund2(Pseq([3,3,3,5],inf),8)/4, \amp, 1);
~k.play;

~sn = Pbind(\instrument, \bplay, \buf, d["s"][0], \dur, Prand([0.5, 1],inf));
~sn.play;
)

(
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,0.25,\amp,Pexprand(0.05,1));
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,0.75,\amp,1);
~c.play;
~h.play;
)

(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf).trace,\amp,1);
~oh.play;
)

(
l = Prewrite(1,
	(
		1:[0.25,2],
		0.25:[1,0.75,0.1,0.3,0.6,0.1],
		0.1:[0.5,1,2],
		2:[0.5, 0.75,0.5,1]
),4);
~h = Pbind(\instrument, \bplay, \buf, d["ch"][0], \dur, l/2, \amp, 1, \rate, 2);
~c = Pbind(\instrument, \bplay, \buf, d["c"][0], \dur, l*2, \amp, 1);
~t = Pbind(\instrument, \bplay, \buf, d["t"][0], \dur, l, \amp, 1, \rate, Pseq([1.2, 1.4, 1.7],inf));
~sn= Pbind(\instrument, \bplay, \buf, d["s"][0], \dur, l*4, \amp,1 ,\rate, 0.2);
~h.play; ~c.play; ~t.play; ~sn.play;
)


/*   VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV   */
(
~k = Pbind(\instrument, \bplay, \buf, d["k"][0], \dur, Pwrand([1, Pseq([0.75],4), Pbjorklund2(3,8,1)/4],[0.9, 0.08, 0.02],inf), \amp, 1);
~k.play;
)
(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~oh.play;
)
/*   VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV   */


(
p.clock.tempo=2.4;
~perc = Pbind(\instrument, \vplay, \buf, d["fx"][1], \rel, 0.03, \dur, 0.25, \pos, Pseq((0..100)/100,inf));
~perc.play;
)

(
p.clock.tempo=2.3;
~perc = Pbind(\instrument, \vplay, \buf, Prand([d["fx"],d["sfx"], d["lfx"]].flat, inf), \rel, 0.1, \dur, 0.25, \pos, Pwhite(0,0.9), \rate, Pwhite(1,3.0));
~perc.play;
)


(
p.clock.tempo = 2.32;
l = Pbjorklund2(Pwhite(3,10),16)/4;
e = Scale.chromatic(\et53);
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-2,2),\octave,Pwrand([3,4],[0.8,0.2],inf),\dur,l,\d,0.4,\a,Pexprand(0.5,30),\amp,0.5,\pan,1);
~ring2 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-2,2),\octave,Pwrand([3,4],[0.8,0.2],inf),\dur,l,\d,0.4,\a,Pexprand(0.5,30),\amp,0.5,\pan,-1);
~ring3 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-5,5),\octave,Pwrand([4,5],[0.8,0.2],inf),\dur,l,\d,0.5,\a,Pexprand(0.5,30),\amp,0.5,\pan,0);
~ring4 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-5,5),\octave,Pwrand([2,3],[0.8,0.2],inf),\dur,l,\d,0.2,\a,Pexprand(0.5,200),\amp,0.9,\pan,0);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,l,\amp,1);
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,l,\amp,Pwhite(0.2,1));
~ring1.play;~ring2.play;~ring3.play;~ring4.play;~sn.play;~c.play;~h.play;
)

(
p.clock.tempo = 2.32;
l = Pbjorklund2(Pseq([3,8,2,5,9,10,14,3,5,5,4,9,14],inf),16)/4;
e = Scale.chromatic(\et53);
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-2,2),\octave,Pwrand([3,4],[0.8,0.2],inf),\dur,l,\d,0.4,\a,Pexprand(0.5,90),\amp,0.5,\pan,1);
~ring2 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-2,2),\octave,Pwrand([3,4],[0.8,0.2],inf),\dur,l,\d,0.4,\a,Pexprand(0.5,90),\amp,0.5,\pan,-1);
~ring3 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-5,5),\octave,Pwrand([4,5],[0.8,0.2],inf),\dur,l,\d,0.5,\a,Pexprand(0.5,90),\amp,0.5,\pan,0);
~ring4 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-5,5),\octave,Pwrand([2,3],[0.8,0.2],inf),\dur,l,\d,Pexprand(0.2,0.6),\a,Pexprand(1,900),\amp,0.9,\pan,0);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,l,\amp,1);
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,l,\amp,Pwhite(0.2,1))
)

(
~k = Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,1,\rate,1,\amp,3);
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,Pwhite(0.5,1),\rate,0.8);
~k.play;
~oh.play;
)
