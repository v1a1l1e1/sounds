(SynthDef(\arp, {
  |freq=8, amp=0.7, out=0, th_m=0.35, th_M =0.95, bel_m=0.9, bel_M=1.5, ab=1.2, c_time=0.001, rx_time = 0.002,d=6|
  var sig;
	sig = Decay2.ar(Impulse.ar([freq, freq-0.4]), 0, LFSaw.kr(0.3, 1, -0.3, 0.3)),0.001,0.3)* Mix.ar(Pulse.ar([80, 81], 0.3));
  sig = Compander.ar(sig,sig,SinOsc.kr(0.01).range(th_m, th_M),SinOsc.kr(0.2).range(bel_m,bel_M),ab,c_time,rx_time);
	Out.ar(out, sig*amp*EnvGen.kr(Env([0,1,1,0],[0,d,d]),doneAction:2));
}).add;)

p = ProxySpace.push(s);
p.fadeTime=4;


~x.clear;

~x = Pbind(\instrument, \arp, \d, Pseq([1],inf), \dur, Pkey(\d), \ab, Pwhite(1.5, 4), \freq, Prand([8,16,4],inf),\amp,0.02);
~x.play;

~flt_send = {Mix.ar([~x.ar])}
~flt = {RLPF.ar(~flt_send.ar, LFNoise1.kr(0.1).range(100,2000), SinOsc.kr(0.3).range(0.05, 0.7))}
~flt.play;

~rev_send = {Mix.ar([~x.ar])}
~rev = {FreeVerb.ar(Mix.ar([~x.ar]),0.9,0.4,0.2)};
~rev.play;

