(

~dust = Group.new();
~dust_rev = Group.after(~dust);
~rev = Bus.audio(s, 2);

SynthDef(\bass,{|freq = 60, amp = 1|
	var sig, env;
	sig = Impulse.ar(freq!2);
	env = EnvGen.ar(Env.perc(0.001, level:4), doneAction:2);
	sig = BPF.ar(sig, 60, 1/60,4);
	sig = sig * amp * env;
	Out.ar(0, sig);
}).add;

SynthDef.new(\kick,{| freq=60, mix = 0.2, room=0.1|
	var sig, env_sig, env_freq, amp=0.5;
	env_freq = EnvGen.kr(Env.perc(0.001,0.2,2.5));
	sig = SinOsc.ar(60!2*env_freq, pi*LFNoise0.kr(2).range(0.25,0.5));
	env_sig = EnvGen.kr(Env.perc(0.001, 0.5, curve:-1), doneAction:0);
	sig = sig*amp*env_sig;
	sig = BPF.ar(sig, 60, 2.5);
	sig = FreeVerb.ar(sig, mix, room);
	Out.ar(0, sig);
	DetectSilence.ar(sig, doneAction:2);
}).add;

SynthDef(\hey,{|out=0, freq=100, phase=0|
	var sig;
	var f = {Dust.kr(freq).exprange(10, 50)}!2;
	sig = Impulse.ar(f, phase, 0.05)*EnvGen.ar(Env.new(times:[3, 6], curve:\sine), doneAction:2);
	Out.ar(out, sig);
}).add;

SynthDef(\rev,{
	var sig = In.ar(~rev, 2);
	sig = FreeVerb.ar(sig, 0.7, 0.6);
	Out.ar(0, sig);
}).add;
)

(
Pdefn(\d1_dur, Prand([0.5],inf));
Pdefn(\d2_dur, Pseq([
	Pseq([0.5, 0.5,0.5,0.5,0.25],10),
	Pseq([0.5, 0.5, 0.25], 5+rand(5)),
	Pseq([1, 0.5, 0.25, 0.75], 1)],inf)
	);
Pdefn(\d2_dur_bis, Pseq([0.5, 0.5,0.5,0.5,0.25],inf));
Pdefn(\d1_freq, Prand([60, 63],inf));

~d1=Pbind(
	\instrument, \bass,
	\dur, Pdefn(\d1_dur),
	\freq, Pdefn(\d1_freq),
	\amp, Pseq([3],inf),
);

~d2=Pbind(
	\instrument, \kick,
	\dur, Pdefn(\d2_dur),
	\freq, Pseq([60], inf),
	\mix, 0.2,
	\room, 0.1,
);
)

(
~density = Prout({ loop { 10.rand.yield;}}).asStream;
{
    ~density.do { |val|
        Synth(\hey,[\out,~rev,\freq, rrand(10, 20), \phase, (0..2).choose*pi],~dust);
		Synth(\rev, target:~dust_rev);
        6.wait;
    }
}.fork;

~global = Ptpar([
	0, ~d1,
	2,~d2,
]).play;
)

/* --- free resources --- */
~density.stop;
~global.stop;
~dust.free;
~dust_rev.free;


/* --- clean all --- */
s.freeAll;
s.meter;
s.plotTree;

s.reboot;
/*(
20.do({
	Synth(\hey,[\out,~rev,\freq, rrand(10, 20), \phase, (0..2).choose*pi],~dust);
	Synth(\rev, target:~dust_rev)
});
)*/

