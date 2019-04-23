"Setup/Setup.scd".loadRelative;

p.clock.tempo = 110/60;
p.fadeTime=5;

~synth2 = Pbind(\instrument, \synth, \dur, 2, \scale, Scale.minor, \root, 0, \ocatve, Pwrand([2,[3,4],[2,3,4]],[0.9,0.08,0.02],inf), \degree, Prand([[0,2,4],[2,4,6],[7,2,4],[1,2,3],[0,-2,-4],[1,3,5],[-1,-3,-5]],inf), \dur, Pwhite(1,1.3), \edur, Prand([1.5,2],inf), \amp, 1);
~synth2.play;


~synth1 = Pbind(\instrument, \synth, \dur, 4, \scale, Scale.minor, \root, 0, \ocatve, Pwrand([2,3],[0.6,0.4],inf), \degree, Prand([[0,2,4],[2,4,6],[1,2,3],[0,-2,-4],[1,3,5],[-1,-3,-5]],inf), \dur, Pwhite(1.2,2.3), \edur, Prand([1.5,2],inf), \amp, 0.5);
~synth1.play;

~sk = Pbind(\instrument, \gplay2, \buf, d["sk"][0],\dur,4, \amp, 0.35);
~sk.play;

~k1 = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pwrand([1,0.5,Pbjorklund2(Pseq([3,5],inf),8,4)/2], [0.3, 0.5, 0.2],inf), \amp, 0.4, \rate, Pwhite(0.8,1.2));
~k1.play;
~k2 = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pwrand([1,0.25,Pbjorklund2(Pseq([5,3],inf),8,4)/2], [0.3, 0.5, 0.2],inf), \amp, 0.4, \rate, Pwhite(0.1,1.8));
~k2.play;
~k3 = Pbind(\instrument, \gplay1, \buf, d["k"][1], \dur, Pbjorklund2(Pseq([5,3],inf),8,16)/4, \amp, 0.4, \rate, Pwhite(1.5,2));
~k3.play;

~hh = Pbind(\instrument, \gplay2, \buf, d["ch"][0], \dur, Prand([4,Pbjorklund2(Pseq([3,5],inf),8)/2],inf), \amp, 0.3, \pan, Pwhite(-1,1.0), \rate, Pwhite(0.9,1.8));
~hh.play;

~harms = {SinOsc.kr(0.1).range(20,50)};
~synth.set(\harms, ~harms);

~synth1.stop(30);
~synth2.stop(30); ~hh.stop(20);
~k2.stop(10);~k1.stop(10);~sk.stop(5);