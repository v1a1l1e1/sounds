("Setup/Setup.scd").loadRelative;

p.fadeTime=5;
~noise = {Pan2.ar(WhiteNoise.ar(0.2), SinOsc.kr(0.1).range(-0.75,0.75))};

~noise_f = {BPF.ar(~noise.ar, LFNoise1.kr(0.1,100,LFNoise1.kr(0.1).range(200,500)),0.6)}
//~noise_f.play;

~noise_r = {RLPF.ar(~noise_f.ar,LFNoise1.kr(0.2).range(200,700),0.6)}
//~noise_r.play;

~noise_fb = {CombC.ar(Decay.ar(~noise_r.ar,2),0.1, LFNoise1.kr(0.01).range(0.001, 0.01),3,2)}
//~noise_fb.play;

~pulse = {Pulse.ar(LFNoise2.kr(0.1).range(80,100), LFNoise1.kr(0.1).range(0.1,0.9),3)}
~pulseG = {GrainIn.ar(1, Impulse.kr(100),0.001,~pulse.ar)}
//~pulseG.play;

~np = {Pan2.ar(~noise_r.ar * ~pulseG.ar,SinOsc.kr(0.1).range(-1,1),2)};
~np.play;

~pulse2 = {Pulse.ar(LFNoise2.kr(0.1).range(150,200), LFNoise1.kr(0.1).range(0.1,0.9),0.3)}
~pulseG2 = {GrainIn.ar(1, Impulse.kr(LFNoise1.kr(0.1).range(0.2,0.9)),0.0001,[~pulse.ar,~noise_fb.ar],mul:0.5)}
~pulseG2.play;

(
~drone = {Pan2.ar(VarSaw.ar([80,80.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1), SinOsc.kr(0.1).range(-0.5,0.25))};
~drone2 = {Pan2.ar(VarSaw.ar([120,120.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1),SinOsc.kr(0.1).range(-0.25, 0.75))};
~drone3 = {Pan2.ar(VarSaw.ar([160,160.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1),SinOsc.kr(0.1).range(-0.25, 0.75))};
~droneH = {RHPF.ar(~drone.ar,LFNoise1.kr(0.1).range(120,400),LFNoise1.kr(0.1).range(0.5, 0.1))};
~droneF = {DFM1.ar(Mix.ar([~drone2.ar,~droneH.ar, ~drone3.ar]), LFNoise1.kr(0.1).range(100,800), LFNoise1.kr(0.1).range(0.1,0.9),0.9,0,0.003)};
~droneF.play;
)

~np.play;
~droneF.play;

~k = Pbind(\instrument, \bplaym, \buf, d["k"][1], \amp, 0.15, \dur, Pbjorklund(Pseq([3,5],inf),8), \rate, Pwhite(0.1,3));
~k.play;
~k2 = Pbind(\instrument, \bplaym, \buf, d["k"][1], \amp, 0.1, \dur, Pbjorklund(Prand([3,5,7],inf),8)/2, \rate, Pwhite(1.5,2.1));
~k2.play;


~ring = Pbind(\instrument, \ring1, \f, Prand([40,60,80,120],inf) *Prand([1,0.5],inf), \a, Pwhite(4,15), \d, Pwhite(2,10), \dur, Prand([0.5,0.25,Pbjorklund2(Prand([3,5],4),8,4)/2],inf), \amp, 0.025);
~ring2 = Pbind(\instrument, \ring1, \f, Prand(([40,60,80]),inf) * Prand([1,0.5,2],inf), \a, Pwhite(4,20), \d, Pwhite(2,8), \dur, Prand([0.5,0.25,Pbjorklund2(3,8,4)/2],inf), \amp, 0.025);
~ring2.play;  ~ring.play;


~k.stop(30)
~np.stop(20);
~droneF.stop(20)
~pulseG2.stop(15)
~ring2.stop(2)