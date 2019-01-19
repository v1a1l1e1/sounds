s.boot;
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

(
SynthDef(\grain,{
	|buf, rate, pos, g_dur, pan, g_amp, int=1,out=0|
	var sig = TGrains.ar(2,Impulse.kr(rate),buf, rate, pos + TRand.kr(0,BufDur.kr(buf),Impulse.kr(rate)), g_dur/rate, pan, g_amp, int);
	var env = EnvGen.kr(Env.perc(0,1),doneAction:2);
	sig = sig*env;
	Out.ar(out, sig);
}).add;
)

x = Pbind(\instrument,\grain, \buf, d["g"][3], \rate, Pwhite(8,10), \g_dur, Pwhite(2,20), \pos, Pwhite(0,50),\pan, Pwhite(-1,1), \g_amp, 1, \dur, 0.25);
x.play;
