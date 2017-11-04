(
SynthDef(\clang, {|out=0, freq=60, amp=0.5,phase=0, atk=0.01, sus=0.5, rel=0.01|
	var sig;
	sig=Klang.ar(`[[freq, freq/3*2, freq*4/3],[amp, amp/2, amp*0.8].scramble,[phase, phase+pi, phase+pi/2]])!2;
	sig = sig*EnvGen.kr(Env([0,1,1,0],[atk, sus, rel]), doneAction:2);
	Out.ar(out, sig*0.25);
}).add;
)

s.meter;

p=ProxySpace.push(s);
p.makeTempoClock(2);
p.fadeTime(1);

(
~clang = Pbind(
	\instrument, \clang,
	\dur, 0.5,
	\freq, Pxrand([[60, 63, 67],[63, 65, 68],[67, 72, 65],[60, 63, 65], [60,57,63], [53, 57, 60]].midicps, inf),
	\amp, Pxrand([0.5, 0.3, 0.4]*0.125, inf),
	\phase, Prand([pi/2, 0, pi/3, pi+1/4], inf),
	\atk, 0.01,
	\sus, Prand([0.5,0.2, 0.8],inf),
	\rel, Pxrand([0.01, 0.07, 0.1],inf),
);
)

~clang.play;


/*-- Record Utility --*/
r = RecNodeProxy.newFrom(~clang);
r.open("recproxy515.aif"); //open file
r.record; //start recorder (paused)

r.unpause; //start recording
r.pause;
r.unpause;
r.pause;


//stop recording and close file
r.close;
