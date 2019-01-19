p = ProxySpace.push(s);
p.makeTempoClock;

p.clock.tempo=1.5;

(
l = Prewrite(0, (0:#[1,0.25,0,0.125,1],1:#[1,1]),10); //binary tree
)

(
~synth = Pbind(\instrument, \default, \freq, 440*l, \dur, l/2, \amp, 0.7);
~synth.play;
)