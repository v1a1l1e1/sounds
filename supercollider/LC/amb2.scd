("Setup/Setup.scd").loadRelative;

// DA UNIRE CON AMBIENT.SCD E DRONE2.SCD //

(
SynthDef(\noise_pad,{
	|out=0, dens=5, amp=2|
	var sig, env;
	sig = WhiteNoise.ar(0.5);
	env = Dust.ar(LFNoise1.kr(dens));
	sig = sig*env;
	DetectSilence.ar(sig,doneAction:2);
	Out.ar(out, Pan2.ar(sig*amp, LFNoise1.kr(0.1).range(-1,1)));
}).add;
)

(
~n = Pbind(\instrument, \noise_pad,\dens, Prand((12..20),inf),\dur, 0.25,\amp,1);
~n.play;
)

(
~drone = {VarSaw.ar([80,80.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1)};
~drone2 = {VarSaw.ar([120,120.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1)};
~droneH = {RHPF.ar(~drone.ar,LFNoise1.kr(0.1).range(120,400),LFNoise1.kr(0.1).range(0.5, 0.1))};
~droneF = {DFM1.ar(Mix.ar([~drone2.ar,~droneH.ar]), LFNoise1.kr(0.1).range(100,800), LFNoise1.kr(0.1).range(0.1,0.9),0.9,0,0.003)};
~droneF.play;
)

(
/*
dur 4 -> 2 -> Pbjorklund2(3,8,inf,2)/2
rel, 0.003, \pos, Prand((0..200)/200,inf)
*/
~g = Pbind(\instrument, \vplay, \buf, d["g"][1], \dur,Pbjorklund2(3,8,inf,2)/2, \amp,0.3, \rate, Pwhite(0.15, 0.25),\rel, 0.003, \pos, Prand((0..200)/200,inf));
~g.play;
)

(
~g2 = Pbind(\instrument, \vplaym, \buf, d["g"][0], \dur,Pbjorklund2(3,8,inf,2)/2, \amp,0.3, \rate, Pwhite(0.5,1), \rel, 0.003, \pos, Prand((0..100)/100,inf));
~g2.play;
)

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][2], \dur, Pbjorklund2(Pseq([3,5],inf),8)/2, \amp, 0.4);
~k.play;
)


