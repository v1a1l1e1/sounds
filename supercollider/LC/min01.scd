(
~sin = {SinOsc.ar([80,80.01],[0,pi],0.3)};
~sin.play;
)

(
~saw = {VarSaw.ar([60,60.05], LFNoise1.kr(0.1).range(0,pi), LFNoise1.kr(0.2).range(0,1),0.3)};
~saw.play;
)

(
~flt = {RHPF.ar(Mix.ar([~sin.ar, ~saw.ar]), LFNoise1.kr(0.3).range(50,100), LFNoise1.kr(0.1).range(0.1, 0.005))};
~flt.play;
)

(
~grain = {GrainIn.ar(2, Impulse.kr(LFNoise1.kr(2).range(10,30)), LFNoise1.kr(0.1).range(0.0001,0.001), Mix.ar([~sin.ar, ~saw.ar]),SinOsc.kr(0.1).range(-1,1),mul:0.7)};
~grain.play;
)

(
~grainB =  {RLPF.ar(GrainIn.ar(2, Impulse.kr(40), 0.0001, Mix.ar([~sin.ar, ~saw.ar, ~flt.ar]),SinOsc.kr(0.1).range(-1,1)),150,0.2,8)};
~grainB.play;
)

~sin.stop(10);
~saw.stop(20);

~flt.stop(30);
~grain.stop(40);
~grainB.stop(20);

p.clear;



