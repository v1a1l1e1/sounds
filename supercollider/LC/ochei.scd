"Setup/Setup.scd".loadRelative;
p.fadeTime = 4;

~sk = Pbind(\instrument, \gplay2, \buf, d["sk"][0],\dur,4,\amp,0.5);
~sk.play;

~k1 = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pbjorklund2(Pseq([3,5],inf),8)/2, \amp, 0.4, \rate, Pwhite(0.2,1.4));
~k1.play;

~k2 = Pbind(\instrument, \gplay1, \buf, d["k"][1], \dur, Pbjorklund2(Pseq([5,3],inf),8,2)/Prand([2,4],inf), \amp, 0.4, \rate, Pwhite(0.5,2.3), \pan, Prand([-0.75, 0.75],inf));
~k2.play;

~bass = Pbind(\instrument, \bass, \scale, Scale.minor, \octave, Prand([2,3],inf), \degree, Prand([0,2,4,5,7,-1,-3],inf),\amp,0.4, \dur, Pbjorklund(3,11)/2);

~sine = {SinOsc.ar([120,120.01],0,1)};
~pulse = {Pulse.ar([20,20.1],LFNoise1.kr(0.1).range(0.1,0.8),1)};
~sig = {~sine.ar * ~pulse.ar};
~sig.play;

~flt = {RLPF.ar(~sig.ar, Lag.kr(LFNoise1.kr(3).range(80,300),0.5),SinOsc.kr(0.2).range(0.1,0.3),2)};
~flt.play; ~sig.stop;

~flt_m = {~flt.ar * ~k1.ar};
~flt.stop; ~flt_m.play;

~synth = Pbind(\instrument, \mu, \dur, 2, \amp, 0.4, \scale, Scale.minor, \octave, Prand([2,3,4],inf), \degree, Pseq([2,5,7,9,2,4,2,4,5,7,-1,-3,2,4],inf));

~k3 = Pbind(\instrument, \gplay2, \buf, d["k"][2],\dur, Prand([1,0.5],inf), \amp, 0.1, \rate, Prand([2,1.1],inf));
~k3.play;

~oh = Pbind(\instrument, \gplay2, \buf, Prand(d["oh"], inf), \amp, 0.02, \rate, Pwhite(0.01,0.8), \dur, Pbjorklund2(Prand([3,5,7],inf), Prand([8,11],inf))/2);

~oh.play;

~sk.stop(30);






