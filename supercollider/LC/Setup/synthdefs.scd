/*

coï¿¥ï¾¡pt SynthDef library

used as part of howto_co34pt_livecode

*/
(

/*

bpfsaw: an instrument by Eli Fieldsteel as part of his SuperCollider tutorial series
A detuned slow-enveloped saw wave which sounds lush and beautiful, especially with some extended chords
Has a lot of arguments,

atk = attack
sus = sustain
rel = release
ts = timescale of the envelope
c1 = start of envelope curve
c2 = end of envelope curve
freq = frequency
detune = detuning (multiple of frequency), works well with low values, higher ones get quite silly
pan = panning in stereo
cfhzmin = minimum modulation of filter frequency
cfhzmax = maximum modulation of filter frequency
cfmin = minimum filter frequency
cfmax = maximum filter frequency
rqmin = controls filter sweeping. Lower values = greater effects of filtering
rqmax = controls filter sweeping. Lower values = greater effects of filtering
lsf = frequency at which low shelf is activated
ldb = low shelf boost (in dB) - gets really glitchy over around 16 dB, but sounds great so I keep it high
amp = volume
out = channels out

*/

(
SynthDef(\bpfsaw, {
	arg atk=2, sus=0, rel=3, ts=1, c1=1, c2=(-1), freq=500, detune=0.02, pan=0, cfhzmin=0.1, cfhzmax=0.3, cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2, lsf=200, ldb=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),timeScale:ts,doneAction:2);
	sig = Saw.ar(freq*{LFNoise1.kr(0.5,detune).midiratio}!2);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin,cfhzmax)
		).exprange(cfmin,cfmax)}!2,
		{LFNoise1.kr(0.1).exprange(rqmin,rqmax)}!2
	);
	sig = BLowShelf.ar(sig,lsf,0.5,ldb);
	sig = Balance2.ar(sig[0],sig[1],pan);
	sig = sig*env*amp;
	Out.ar(out,sig);
}).add;
);

/*

sinfb: General purpose SinOscFB Ugen designed to mutate between pure sine waves and noise using the feedback argument.
A SynthDef that gets heavy use from me, works well for bass, chords and melody.

freq = frequency
atk = attack
sus = sustain
rel = release
fb = feedback (generally useful values are from 0-2, with 0 being pure sine waves and 2-20 being noise. More info on this in 'Between Pitch and Noise' section of guides)
amp = volume
out = channels out
pan = panning in stereo

*/

(
SynthDef(\sinfb, {
	arg freq = 440, atk = 0.01, sus = 0, rel = 1, fb = 0, amp = 0.3, out = 0, pan=0;
	var sig, env;
	env = EnvGen.ar(Env.linen(atk,sus,rel),1,1,0,1,2);
	sig = SinOscFB.ar(freq,fb,1);
	sig = sig*env;
	Out.ar(out,Pan2.ar(sig,pan,amp));
}).add;
);

/*

ring1: a Ringz-based synth which is inspired by this: http://sccode.org/1-1b
ring2, ring3 and ring4 represent the other tones used in this example, but I don't use them. They have been left in in case I would like to use the original combination of frequencies
the .tanh gives a wonderful squelch when driven very hard, and at low frequencies it resembles an acid bass

f = frequency (the reason this isn't freq is because it doesn't seem to work)
a = amplitude of Ringz (before the final multiplier so that a heavily distorted signal can be later scaled by amp)
d = duration of envelope on Ringz
pan = Pan in stereo
amp = overall volume
out = channels out

*/

SynthDef(\ring1,
	{
		arg f = 45, a = 9, d = 0.6, pan = 0, amp = 1, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;

/*--------------------------------------------------------------------------------*/
/* PLAYERS */

/* -----------------------------------------------------------------------------

example:

~buf1 = Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav");

~buf2 = Buffer.read(s,"/home/v1a1l1e1/Documenti/scripts/livecoding/SuperCollider_projects/LC/samples_SC/g/inv.wav");

(
x = Pbind (\instrument, \gplay2, \buf, ~buf2,\rate, Pwhite(-3.2,3), \dur, 0.125, \pos, Pwhite(0, 1),\d, Pwhite(0.3, 1), \trig, Pbjorklund2(3,8)/4, \amp, 1);
x.play;

y = Pbind (\instrument, \g_play1, \buf, ~buf1,\rate, Pwhite(-3.2,3), \dur, Pwhite(0.125, 1), \start, Pwhite(0, 2), \end, Pwhite(0.3, 1), \reset, Pwhite(0, 0.75), \d, Pwhite(0.3, 1), \trig, Pbjorklund2(3,8)/4);
y.play;
)
----------------------------------------------------------------------------- */


/* BufRd mono */
SynthDef(\g_play1, {
	|out=0, buf, rate=1,int=1, amp=1, start=0, end=1, reset=0, d=1, trig=0|
	var sample, env;
	sample = BufRd.ar(1, buf,Phasor.ar(trig,BufRateScale.ir(buf)*rate, start,BufFrames.kr(buf)*end,BufFrames.kr(buf)*reset),0,int);
	env = EnvGen.kr(Env.linen(0.001,BufDur.kr(buf)*d,0.001),doneAction:2);
	Out.ar(out, Pan2.ar(sample*env,0,amp));
}).add;

/* BufRd stereo */
SynthDef(\g_play2, {
	|out=0, buf, rate=1,int=1, amp=1, start=0, end=1, reset=0, d=1, trig=0, pan=0|
	var sample, env;
	sample = BufRd.ar(2, buf,Phasor.ar(trig,BufRateScale.ir(buf)*rate, start,BufFrames.kr(buf)*end,BufFrames.kr(buf)*reset),0,int);
	env = EnvGen.kr(Env.linen(0.001,BufDur.kr(buf)*d,0.001),doneAction:2);
	Out.ar(out, Pan2.ar(sample*env,pan,amp));
}).add;

/* PlayBuf mono */
SynthDef(\gplay1,
	{
		|out=0, buf=0, rate=1, d=15, trig=1, pos=0, amp=0.5, pan=0|
		var sig,env;
		sig = PlayBuf.ar(1,buf,BufRateScale.ir(buf) * rate,trig,BufDur.kr(buf)*pos*s.sampleRate,doneAction:2);
		env = EnvGen.ar(Env.linen(0.0,d,0),doneAction:2);
		sig = sig * env;
		Out.ar(out,Pan2.ar(sig*amp,pan));
}).add;

/* PlayBuf stero */
SynthDef(\gplay2,
	{
		|out=0, buf=0, rate=1, d=15, trig=1, pos=0, amp=0.5, pan=0|
		var sig,env;
		sig = PlayBuf.ar(2,buf,BufRateScale.ir(buf) * rate,trig,BufDur.kr(buf)*pos*s.sampleRate,doneAction:2);
		env = EnvGen.ar(Env.linen(0.0,d,0),doneAction:2);
		sig = sig * env;
		Out.ar(out,Pan2.ar(sig*amp,pan));
}).add;


/*granulatore stereo
 out = out channel
 in = input buffer
 fm = valore minimo di variazione della frequenza del trigger
 fM = valore massimo di variazione della frequenza del trigger
 dur = durata del grano
 offm = offset minimo di variazione nella posizione
 offM = offset massimo di variazione nella posizione
 r = rate
*/
SynthDef(\tgrain, {
	|out = 0, in, fm=2, fM=200, d=4,offm=0, offM=0.01, r=1,on=0|
	var trigger, tfreq, buf, rate, pos, dur,pan, amp,int;
	rate = LFNoise1.kr(1);int=4;amp=0.1;
	buf = in;
	tfreq = LFNoise1.kr(0.5).range(fm,fM,1);
	dur = d/tfreq;
	rate = r;
	trigger = Impulse.kr(tfreq*on);
	pos = LFNoise1.kr(0.6).range(0.7, (BufDur.kr(buf)/100*80)) + TRand.kr(offm,offM,trigger).postln;
	pan = WhiteNoise.kr(0.6);
	Out.ar(out, TGrains.ar(2, trigger, buf, rate, pos, dur, pan, amp, int));
}).add;

/*--------------------------------------------------------------------------------*/
/* PERCUSSIONI */

SynthDef(\kick,{
	| out=0, mix = 0.2, room=0.1, amp=0.5|
	var sig, env_sig, env_freq;
	env_freq = EnvGen.kr(Env.perc(0.001,0.2,2.5));
	sig = SinOsc.ar(60!2*env_freq, pi*LFNoise0.kr(2).range(0.25,0.5));
	env_sig = EnvGen.kr(Env.perc(0.001, 0.5, curve:-1), doneAction:0);
	sig = sig*amp*env_sig;
	sig = BPF.ar(sig, 60, 2.5);
	sig = FreeVerb.ar(sig, mix, room);
	Out.ar(out, sig);
	DetectSilence.ar(sig, doneAction:2);
}).add;


SynthDef(\kick2,{
	| out=0, amp=0.5|
	var sig, env_sig, env_freq;
	env_freq = EnvGen.kr(Env.perc(0.001,0.2,2.5));
	sig = SinOsc.ar(60!2*env_freq, pi*LFNoise0.kr(2).range(0.25,0.5));
	env_sig = EnvGen.kr(Env.perc(0.001, 0.5, curve:-1), doneAction:2);
	sig = BPF.ar(sig, 60, 2.5)*amp*env_sig;
	Out.ar(out, sig);
}).add;

SynthDef(\kick3,{
	|out=0, amp=1|
	var sig, body, beat, env, freq, width;
	freq = EnvGen.ar(Env([60, 110, 30],[0.001, 0.004], [-4,-4]));
	width = EnvGen.ar(Env([0.3, 0.5, 0.3],[0.001, 0.002], [-4, -4]));
	env = EnvGen.kr(Env([0,1,0],[0.1, 0.2]), doneAction:2);
	body = LFPulse.ar(freq,0,width,0.05);
	body = LPF.ar(body, freq,env);
	beat = SinOsc.ar(freq,0,2);
	beat = Resonz.ar(beat, freq*2,0.1,1.5);
	sig = body + beat;
	sig = sig*env*1.1;
	Out.ar(out, Pan2.ar(sig!2)*amp);
}).add;

SynthDef(\k,{|out=0, amp=1|
	var sig, env, freq, body, env_b;
	freq = EnvGen.ar(Env([100, 60, 20],[0.001, 0.02]));
	sig =  LFPulse.ar(freq,0, 0.5);
	env = EnvGen.kr(Env([0.5,1,0.5,0],[0.001, 0.05, 0.2],[-4,-2,-4]), doneAction:2);
	sig = sig*env;
	body = SinOsc.ar(freq,0, env);
	body = body + WhiteNoise.ar(0.5);
	sig = sig + body;
	sig = LPF.ar(sig, freq*1.5, env);
	sig = sig * 1.1;
	sig = sig.clip2(0.8);
	Out.ar(out, sig!2*amp);
}).add;

SynthDef(\hh, {|amp= 1, rel= 0.05, f_c = 5000, out=0|
	var e= EnvGen.ar(Env.perc(0, rel, amp, -10), doneAction:2);
    var z= WhiteNoise.ar(e);
    z= BPF.ar(z, f_c, 0.4);
    Out.ar(out, Pan2.ar(z, 0, 1.5));
}).add;

SynthDef(\bz, {|amp= 1, rel= 0.25, freq= 400|
	var e= EnvGen.ar(Env.perc(0.01, rel, amp), doneAction:2);
    var z= BPF.ar(Blip.ar(e+1*(freq*0.1), 3), freq*2, 0.1, amp*10*e);
	Out.ar(0, Pan2.ar(z, 0));
}).add;

SynthDef(\bd, {|amp= 1, rel= 0.1, out=0|
	var e= EnvGen.ar(Env.perc(0, rel, amp, -10), doneAction:2);
    var z= Mix(SinOsc.ar(#[150, 160, 170], 0, e*0.4));
	Out.ar(out, Pan2.ar(z, 0));
}).add;

SynthDef(\rotC,{
	|out=0, amp=0.9|
	var sig, sig_c, env, freq;
	freq = EnvGen.ar(Env([60, 110, 30], [0.004, 0.004], [4, -4]));
	sig = Pulse.ar(freq!2) + LFTri.ar(freq*1.1, mul:1.2) + WhiteNoise.ar(1);
	env = EnvGen.ar(Env([0,0.9,0], [0.01, 0.4]), doneAction:2);
	sig = LPF.ar(sig, freq*1.7);
	sig_c = Compander.ar(sig,sig,0.95,1,0.001,0.001,0.07,1.2);
	sig_c = HPF.ar(sig_c, 50);
	sig_c = sig_c*env;
	Out.ar(out, sig_c*amp);
}).add;

SynthDef(\glitchy2, {
	|v1=3, freq=120, amp=0.8|
	var sig, env;
	sig = Saw.ar([v1, v1+rand(1,3)],0.5)*SinOsc.ar({LFNoise1.kr(2).exprange(freq, freq*2+10)}!2);
	env = EnvGen.kr(Env([0,1,1,0],[0.01,0.05,0.01]), doneAction:2);
	sig = AllpassN.ar(sig, 0.8, 0.4, 2)*env;
	Out.ar(0, Pan2.ar(sig, SinOsc.kr(0.2).range(-1,1),amp));
}).add;

/*--------------------------------------------------------------------------------*/
/* SYNTH */

SynthDef(\ringM, {|out=0,freq=200, mod=50, amp_mod=1, amp=1,fb=1|
	var sig, osc_car, osc_mod, env;
	osc_mod = SinOscFB.ar(mod, fb, mul:amp_mod);
	osc_car = SinOsc.ar(freq, mul:osc_mod);
	env = EnvGen.kr(Env([0, 1, 1, 0], [0.5, 1, 0.5]), doneAction:2);
	sig = osc_car * amp * env;
	Out.ar(out, sig);
}).add;

SynthDef(\pad, {
	|freq= 220, amp=1, phase=0, mix=0.8, out=0|
	var sig, env,lpf;
	sig = Mix.ar([LFPar.ar(freq,SinOsc.kr(1).range(0,pi)) + LFTri.ar(freq/2, phase, 0.25),
		LFPar.ar(freq*2,0) + LFTri.ar(freq/3, phase, 0.25)]);
	env = EnvGen.kr(Env([0,1,1,0],[0.1, 0.3, 0.5],\sine), doneAction:2);
	sig = sig*env;
	sig = LPF.ar(sig, freq);
	sig = Resonz.ar(sig, SinOsc.kr(2).range(freq/2, freq*2), 0.1);
	sig = FreeVerb.ar(sig, mix);
	Out.ar(out, Pan2.ar(sig*amp, 0));
}).add;

SynthDef(\synth,{|out = 0, freq=220, harms=50, edur=1,amp=1|
	var sig, env;
	sig = Blip.ar(freq, harms) + VarSaw.ar(freq, mul:0.2);
	env = EnvGen.kr(Env.sine(edur), doneAction:2);
	sig = Resonz.ar(sig, SinOsc.kr(edur/2).range(freq/2, freq*2), 0.1);
	sig = DFM1.ar(sig!2, freq, 0.5);
	Out.ar(out, sig*env*amp);
}).add;

SynthDef(\bass,{
	|out=0,freq=100, amp=0.9|
	var sig, sig2, sig1, env1, env2;
	sig1 = LFTri.ar(freq!2);
	sig1 = LPF.ar(sig1, freq/3*2);
	env1 = EnvGen.kr(Env.linen(0.01,0.3,0.1), doneAction:2);
	sig2 = SinOsc.ar(freq/3*2);
	env2 = EnvGen.kr(Env.perc(0.001,0.01));
	sig2 = LPF.ar(sig2, freq/3*2);
	sig2 = sig2*env2;
	sig1 = sig1 + sig2;
	sig1 = DFM1.ar(sig1, freq);
	sig = sig1*env1;
	Out.ar(out, sig*amp);
}).add;

SynthDef(\bass2,{
	|out=0,freq=100, amp=0.9|
	var sig, sig2, sig1, env1, env2;
	sig1 = Saw.ar(freq!2);//LFTri.ar(freq!2);
	sig1 = LPF.ar(sig1, freq/1.1);
	env1 = EnvGen.kr(Env.linen(0.01,0.3,0.25), doneAction:2);
	sig2 = SinOsc.ar(freq/3*2);
	env2 = EnvGen.kr(Env.perc(0.001,0.01));
	sig2 = LPF.ar(sig2, freq/3*2);
	sig2 = sig2*env2;
	sig1 = sig1 + sig2;
	sig1 = DFM1.ar(sig1, freq);
	sig = sig1*env1;
	Out.ar(out, sig*amp);
}).add;

SynthDef(\fm,{
	|out=0, amp=1,freq=60,tempo=1|
	var car_f, mod_f, mod_idx, amp_env, mod, car;
	car_f = EnvGen.kr(Env(
		freq!8,
		//[50,50,50,50,50,50,50,50],
		[0.7,0.75,0.7,0.7,0.7,0.75,0.7]/tempo));
	mod_f = EnvGen.kr(Env(
		freq!8,
		//[50,50,50,50,50,50,50,50],
		[0.7,0.75,0.7,0.7,0.7,0.75,0.7]/tempo));
	mod_idx = EnvGen.kr(Env(
		[0,7.1,10,8.1,7.1,5.7,3.9,2.5],
		[0.75,0.14,0.65,0.05,0.045,0.06,0.65]/tempo));
	amp_env = EnvGen.kr(Env(
		[0,0.31,0.75,0.81,0.91,0.53,0.14,0],
		[0.025,0.03,0.6,0.035,0.17,0.12,0.06]/tempo),doneAction:2);
	mod = SinOsc.ar(mod_f,0,mod_f*mod_idx);
	car = SinOsc.ar(car_f+mod,0,amp_env);
	Out.ar(0, [car,car]*amp);
}).add;

SynthDef(\base_fm, {
	|freq=220, mod_freq = 100,out=0, amp=1|
	var mod_amp, car, mod, lfo, amp_lfo, env_lfo, env_amp;
	env_lfo = EnvGen.ar(Env([0,1,1,0], [0.01,0.02,0.02])); // dur = 0.5
	lfo = SinOsc.ar(1/0.05,0,env_lfo);
	mod = Pulse.ar(mod_freq,0, lfo*mod_freq);
	env_amp = EnvGen.ar(Env([0,1,1,0],[0.01, 0.08, 0.02]),doneAction:2);
	amp_lfo = SinOsc.ar(1/0.11,0,mul:env_amp);
	car = SinOsc.ar(mod+freq,0,amp_lfo);
	Out.ar(out, Pan2.ar(car*amp,0));
}).add;

SynthDef(\raw, {
	|freq = 440, out=0, amp=0.5, timeScale=1|
	var sig, env;
	sig = SinOsc.ar(freq!2 *LFSaw.ar(EnvGen.ar(Env([0, 0.4,0], [0.001, 0.001], \sine))).range(0,1));
	sig = sig + Mix.ar([LFTri.ar(freq/2, mul:0.25), LFTri.ar(freq*3/2, pi/2, 0.25), LFTri.ar(freq*5/4, pi, 0.25)]);
	sig = LPF.ar(sig, freq*3);
	sig = BPF.ar(sig, freq*3/2, 0.6);
//	sig = Resonz.ar(sig, SinOsc.kr(0.1).range(freq, freq*3), 0.5);
//	sig = FreeVerb.ar(sig, 0.3, 0.8,mul:1.5);
	env = EnvGen.ar(Env([0,1,1,0],[0.1, 0.3, 0.1]/2*timeScale,\lin), doneAction:2);
	sig = sig*env;
	Out.ar(out, sig*amp);
}).add;

/*--------------------------------------------------------------------------------*/
/* DRONES */

SynthDef(\82, {
	|out=0,base_freq=3, freq_l=1, freq_r=1.01, phase=0, mul=100, add=230, amp=4, atk=3, sus=2, rel=3, rq=0.001|
	var sig, env;
	sig = Saw.ar(LFSaw.kr(base_freq * [freq_l, freq_r], phase, mul, add));
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel],\sine),doneAction:2);
	sig = BPF.ar(sig, base_freq*mul, rq);
	Out.ar(out, sig*amp*env);
}).add;

SynthDef(\mu, {|out=0,freq = 200, fb=0.5, amp=0.5|
	var sig, env;
	sig = SinOscFB.ar([freq, freq+1.1, freq-1.1, freq+0.5], fb);
	env = EnvGen.kr(Env.linen(0.1, 1, 1.7, 3,\sine), doneAction:2);
	sig = FreeVerb.ar(sig, 0.8, 0.9, 0.7);
	sig = Resonz.ar(sig, LFNoise0.kr(0.5).range(freq/2, freq*3/2), 0.1);
	Out.ar(out, Splay.ar(sig*env)*amp);
}).add;

/*--------------------------------------------------------------------------------*/
/* FX */

SynthDef(\fgh,{|out=0,freq=200, fb=0.5, atk=0.01, sus=0.3, rel=0.2, amp=0.25, f=200, rq=0.2, w=0.4,bpf_amp=1|
	var sig, env;//, dry, wet;
	sig = FreqShift.ar(SinOscFB.ar(LFTri.ar(0.2!2).exprange(freq/4, freq/2), fb)*LFTri.ar(freq/3), freq/10);
	env = EnvGen.kr(Env.linen(atk, sus, rel), doneAction:2);
	sig = BPF.ar(sig, f, rq, bpf_amp);
	Out.ar(out, sig*env*amp);
}).add;

SynthDef(\bub, {|freq=220, density=20, pan=0, envbuf=(-1), out=0|
	var sig, env;
	sig = GrainSin.ar(2, Dust.kr(density), 0.01, freq, pan, envbuf, 256);
	Out.ar(out, sig);
}).add;

SynthDef(\blip, {
	|out=0, freq = 1000, harms = 50|
	var sig, env;
	sig = Blip.ar([LFNoise1.kr(0.7).range(freq-1.1, freq+1.1), LFNoise1.kr(0.5).range(freq-0.5, freq+0.5)], harms,3)*SinOsc.ar(3).range(0.1, 1);
	sig = LPF.ar(sig, 3000);
	sig = Resonz.ar(sig, SinOsc.kr(1.5).range(freq/2, freq*2), 0.01, 4);
	env = EnvGen.kr(Env([0,1,1,0], [4,1.5,1], \sine), doneAction:2);
	Out.ar(out, sig*env);
}).add;

SynthDef(\medium, {
	|freq=1500, mod=10, amp=0.9, out=0|
	var sig, env;
	sig = PMOsc.ar(freq!2, mod, SinOsc.kr(10).range(-pi, pi),SinOsc.kr(20).range(-pi, pi));
	sig = BPF.ar(sig, SinOsc.kr(2).range(freq/2, freq*2), 0.1, 1.01);
	env = EnvGen.kr(Env([0,1,0.75,0],[0.1, 0.3, 0.2],[3, 2, -4]), doneAction:2);
	Out.ar(out, sig*amp*env);
}).add;

SynthDef(\arp, {
	|freq=8, amp=0.7, out=0|
	var sig;
	sig = Decay2.ar(Impulse.ar([freq, freq+0.4], 0, LFSaw.kr(0.3, 1, -0.3, 0.3)),0.001,0.3)* Mix.ar(Pulse.ar([80, 81], 0.3));
	sig = Compander.ar(sig,sig,SinOsc.kr(0.1).range(0.75, 0.95),1,0.5,0.01,0.01);
	Out.ar(out, sig*amp);
}).add;

SynthDef(\player, {
	|out=0,lpf_f=2000, hpf_f=2000, res_f=2000,qr=0.9, makeup=1, amp=1, dur_=1|
	var sig, env_pulse_f, env_pulse_a, env_noise;
	env_pulse_f = Env([0.1, 0.9, 0],[0.4, 0.61]);
	env_pulse_a = Env.perc(0.01,0.5);
	env_noise = Env.perc(0.01, 0.01);
	env_pulse_f = env_pulse_f.duration=dur_;
	sig = LFPulse.ar(60*EnvGen.ar(env_pulse_f),mul:EnvGen.ar(env_pulse_a,doneAction:2)) *
	SinOsc.ar(1/1.01) +
	BPF.ar((WhiteNoise.ar*EnvGen.ar(env_noise)), 120, 0.5);
	sig = LPF.ar(sig, lpf_f,3);
	sig = HPF.ar(sig, hpf_f,3);
	sig = Resonz.ar(sig, res_f,qr, (1/qr));
	Out.ar(out, Pan2.ar(sig*(amp*makeup), 0));
}).add;

SynthDef(\dust, {
	|out=0, gate = 1, roomsize = 200, revtime = 450, amp=1, f_d=6, f_n=1|
	var src, env, gverb;
	env = EnvGen.kr(Env([0, 1, 0], [1, 4], [4, -4], 1), doneAction: 2);
	src = Resonz.ar(Array.fill(4, {Dust.ar(f_d)}),1760 * [1, 2.2, 3.95, 8.76] + Array.fill(4, {LFNoise2.kr(f_n, 20)}),0.01).sum * 30.dbamp;
	gverb = GVerb.ar(src,roomsize,revtime,0.99,LFNoise2.kr(0.1).range(0.9, 0.7),LFNoise1.kr(0.2).range(0.2, 0.6), -60.dbamp,-18.dbamp,3.dbamp,roomsize);
	Out.ar(out, gverb * amp*env)
}).add;



SynthDef(\noiz, {|out=0,freq = 50, pan = 0, attack = 0.01, release = 0.3, amp=0.08|
	var sig, env;
	sig = SinOsc.ar(Dust2.kr(LFClipNoise.kr(freq!2).exprange(50,200),3));
	env = EnvGen.ar(Env.perc(attack, release),doneAction:2);
	sig = Pan2.ar(sig, pan);
	Out.ar(out, sig*amp);
}).add;

SynthDef(\wo,{
	|freq=880, out=0,timeScale=1, amp=1|
	var sig, n=20;
	sig = BPF.ar(
		Resonz.ar(
			Mix.fill(n,{|i|
				SinOsc.ar(
					freq+i.rand*LFPulse.kr(1/0.0016,0,EnvGen.kr(Env([0,1,1,0],[0.0003,0.001,0.0003]))),
					0,
					EnvGen.kr(Env([0,1,1,0],[0.1,0.2,0.2]/timeScale), doneAction:2))})*n.reciprocal,
			LFTri.kr(0.1).range(200, 4000),
			SinOsc.kr(0.2).range(0.5, 0.1)
	), 800, 0.4,2);
	Out.ar(out, Pan2.ar(FreeVerb.ar(sig, 0.6, 0.75), SinOsc.kr(0.2).range(-1,1))*amp);
}).add;

SynthDef(\dst, {
	|out=0,freq=200, dfreq=10, pan=0, amp=1|
	var sig, env;
	sig = SinOsc.ar(freq, mul: Dust.kr(dfreq));
	env = EnvGen.kr(Env.perc(0, 0.3), doneAction:2);
	sig = sig * env;
	Out.ar(out, Pan2.ar(sig, pan, amp));
}).add;


)
