p.fadeTime=10;

~sine_f = {LFNoise0.kr(0.1).range(50,80)};
~sine = {SinOsc.ar([~sine_f.kr,~sine_f.kr+1],0,0.5)};
~pulse = {Pulse.ar([20,21],Lag.kr(LFNoise1.kr(0.2).range(0.1,1),0.3),0.5)};

~sp = {~sine.ar*~pulse.ar};
~sp.stop;

~sp_flt = {RLPF.ar(Mix.ar([~sp.ar]),SinOsc.kr(0.1).range(20,300), LFNoise1.kr(0.2).range(0.001,0.02),0.6)};
~sp_flt.stop;

~sp_del = {CombC.ar(Mix.ar([~sp.ar, ~sp_flt.ar, (~sp.ar*~sp_flt.ar*0.2)]),0.3, 1,4)};
~sp_del.play;

~wl = {WaveLoss.ar([SinOsc.ar(300!2),PinkNoise.ar(1)].mean,LFNoise0.kr(0.2).range(0,40),40,LFNoise1.kr(0.1).range(1,2).round(1),0.1)};
~wl.play;

~pwl = {Pan2.ar(~wl.ar,LFNoise0.kr(0.2).range(-1,1))};
~pwl.play;~wl.stop;

~gendy = {Pan2.ar(Normalizer.ar(RLPF.ar(RLPF.ar(Mix.new(Gendy3.ar(freq:[230, 419, 546, 789])),MouseX.kr(10,10000,'exponential'),0.05),MouseY.kr(10,10000,'exponential'),0.05),0.9),Lag.kr(LFNoise0.kr(1),0.5),1)}

~gendy.stop;

~gendy_del = {CombC.ar(~gendy.ar,0.3,0.5,2)};
~gendy_del.play;~gendy.play;

p.clear;