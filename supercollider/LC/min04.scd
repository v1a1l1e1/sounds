("Setup/Setup.scd").loadRelative;

TGrains

~g = Pbind(\instrument, \grain, \buf, d["g"][3], \rate, 1, \g_dur, 1, \pos, 20,\pan, Pwhite(-1,1), \g_amp, 2, \dur, 0.25);
~g.play;

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

(
SynthDef(\grain, {
	|t_fm=8, t_fM=120, g_dur=12, p=0.01,pan=0,out=0, int=4, amp=0.1, rate=1,buf|
	var sig, pos, dur,trate, trigger;
	trate = LFNoise1.kr(0.1).kr(t_fm,t_fM,1);
	dur = g_dur/trate;
	trigger = Impulse.kr(trate);
	pos = LFNoise1.kr(0.1).range(0, BufDur.kr(buf)) + TRand.kr(0, p, trigger);
	sig = TGrains.ar(2, trigger, buf, rate, pos,g_dur, pan, amp,int );
	Out.ar(out, sig);
}).add;
)

(
{
    var trate, dur, clk, pos, pan;
    trate = MouseY.kr(8,120,1);
    dur = 12 / trate;
    clk = Impulse.kr(trate);
    pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
    pan = WhiteNoise.kr(0.6);
    TGrains.ar(2, clk, b, 1, pos, dur, pan, 0.1);
}.scope(zoom: 4);
)