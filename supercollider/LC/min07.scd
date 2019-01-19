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
~pulseG2 = {GrainIn.ar(1, Impulse.kr(LFNoise1.kr(0.1).range(0.2,0.6)),0.0001,[~pulse.ar,~noise_fb.ar],mul:0.5)}
~pulseG2.play;

(
~drone = {Pan2.ar(VarSaw.ar([80,80.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1), SinOsc.kr(0.1).range(-0.5,0.25))};
~drone2 = {Pan2.ar(VarSaw.ar([120,120.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1),SinOsc.kr(0.1).range(-0.25, 0.75))};
~drone3 = {Pan2.ar(VarSaw.ar([160,160.1],[0,0.5],LFNoise1.kr(0.1).range(0.1,0.8),0.1),SinOsc.kr(0.1).range(-0.25, 0.75))};
~droneH = {RHPF.ar(~drone.ar,LFNoise1.kr(0.1).range(120,4000),LFNoise1.kr(0.1).range(0.5, 0.1))};
~droneF = {DFM1.ar(Mix.ar([~drone2.ar,~droneH.ar, ~drone3.ar]), LFNoise1.kr(0.1).range(100,800), LFNoise1.kr(0.1).range(0.1,0.9),0.9,0,0.003)};
~droneF.play;
)

(
~drone4 = {Pan2.ar(VarSaw.ar([80,80.1]*2,[0,0.5],LFNoise1.kr(0.05).range(0.1,0.8),0.1), SinOsc.kr(0.1).range(-0.5,0.25))};
~drone5 = {Pan2.ar(VarSaw.ar([120,120.1]*2,[0,0.5],LFNoise1.kr(0.5).range(0.1,0.8),0.1),SinOsc.kr(0.1).range(-0.25, 0.75))};
~drone6 = {Pan2.ar(VarSaw.ar([160,160.1]*2,[0,0.5],LFNoise1.kr(0.05).range(0.1,0.8),0.1),SinOsc.kr(0.1).range(-0.25, 0.75))};
~drone2H = {RHPF.ar(~drone4.ar,LFNoise1.kr(0.1).range(300,8000),LFNoise1.kr(0.1).range(0.5, 0.1))};
~drone2F = {DFM1.ar(Mix.ar([~drone5.ar,~drone2H.ar, ~drone6.ar]), LFNoise1.kr(0.1).range(100,800), LFNoise1.kr(0.1).range(0.1,0.9),0.9,0,0.003)};
~drone2F.play;
)

~np.play;
~droneF.play;

~k = Pbind(\instrument, \bplaym, \buf, d["k"][1], \amp, 0.15, \dur, Pbjorklund(Prand([3,5,4],inf),8), \rate, Pwhite(0.1,3));
~k3 = Pbind(\instrument, \bplaym, \buf, d["k"][1], \amp, 0.15, \dur, Pbjorklund(Prand([3,5],inf),8,inf,4), \rate, Pwhite(2,5));
~k2 = Pbind(\instrument, \bplaym, \buf, d["k"][1], \amp, 0.1, \dur, Pwrand([1,Pbjorklund(Prand([3,5,7],8),Prand([8,13],8))],[0.8,0.2],inf), \rate, Pwhite(1.5,4));
~k.play;~k2.play;~k3.play;


~ring = Pbind(\instrument, \ring1, \f, Pseq([40,60,80,120],inf) *Prand([1,0.5],inf), \a, Pwhite(4,15), \d, Pwhite(2,10), \dur, Prand([0.5,0.25,Pbjorklund2(Prand([3,5],4),8,4)/4],inf), \amp, 0.025);
~ring2 = Pbind(\instrument, \ring1, \f, Pseq(([40,60,80,(40/3*2)]),inf), \a, Pwhite(4,20), \d, Pwhite(2,8), \dur, Prand([0.5,0.25,Pbjorklund2(3,8,4)/2],inf), \amp, 0.025);
~ring3 = Pbind(\instrument, \ring1, \f, Pseq(([40,60,80,(40/3*2)]*2).reverse,inf), \a, Pwhite(2,5), \d, Pwhite(2,8), \dur, Prand([0.5,0.25,Pbjorklund2(3,8,4)/2],inf), \amp, 0.025);
~ring4 = Pbind(\instrument, \ring1, \f, Pseq(([40,60,80,(40/3*2)]*4).scramble,inf), \a, Pwhite(1,4), \d, Pwhite(1,3), \dur, Prand([0.5,0.25,Pbjorklund2(3,8,4)/2],inf), \amp, 0.025);
~ring2.play;  ~ring.play; ~ring3.play;~ring4.play;


~k2.stop(60)
~np.stop(20);
~droneF.stop(40)
~pulseG2.stop(15)
~ring.stop(2); ~ring2.stop(20); ~ring3.stop(15); ~ring4.stop(10);



p.clear;