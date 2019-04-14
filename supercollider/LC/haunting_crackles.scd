"Setup/Setup.scd".loadRelative;

p.fadeTime=20;

~freqS = {LFNoise0.ar(0.5,30,80)};
~freqP = {LFNoise0.ar(0.2,20,30)};

~sine = {SinOsc.ar([~freqS.ar,~freqS.ar+1],0,0.2)};
~pulse = {Pulse.ar([~freqP.ar, ~freqP.ar+1],LFNoise0.kr(0.3).range(0.5,0.6),0.2)};
~bass = {~sine.ar * ~pulse.ar};
~bass.stop(10);


~g1 = Pbind(\instrument, \gplay1, \buf, d["g"][0],\amp, 0.3, \dur, Pbjorklund2(3,8)/2, \rate, Prand([1,0.5,1.1],inf));
~g2 = Pbind(\instrument, \gplay2, \buf, d["g"][1], \amp, 0.07, \dur, 0.25, \rate, Prand([1,0.5,1.5],inf));

~g1.stop(20);~g2.stop(15);

~rev_send = {Mix.ar([~g1.ar, ~g2.ar])};
~lpf_send = {Mix.ar([~rev.ar, ~bass.ar])};

~rev = {FreeVerb.ar(~rev_send.ar, 1, 0.8,0.6,1.1)};
~rev.stop(10);

~lpf = {RLPF.ar(~lpf_send.ar, SinOsc.kr(0.1).range(100,600), LFNoise1.kr(0.2).range(0.1,0.5),0.3)};
~lpf.stop(5);

