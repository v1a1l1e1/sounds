"Setup/Setup.scd".loadRelative;

~t = Pbind(\instrument, \medium, \amp, 1, \dur,Prand([0,4],inf), \freq, Pwhite(200,1000).round(50));
~t.stop;

~fgh = Pbind(\instrument, \fgh, \dur, 1, \amp, 1, \freq, 800);
~fgh.stop;

~g = Pbind(\instrument, \g_play1, \buf, d["g"][0], \amp, 0.5,\start, 0.5, \trig, Prand([0,1],inf),\d,0.1, \dur, 1);
~gd = Pbind(\instrument, \g_play1, \buf, d["g"][0], \amp, 0.4,\start, 0.5, \trig, Prand([0,1],inf),\d,0.1, \dur, Pseq([0.5, Pseq([1],inf)],inf), \rate, -0.1);
~gu = Pbind(\instrument, \g_play1, \buf, d["g"][0], \amp, 0.4,\start, 0.25, \trig, Prand([0,1],inf),\d,0.5, \dur, Pseq([0.75, Pseq([1],inf)],inf), \rate,1.1);
~g.play;
~gd.play; ~gu.play;

~k1 = Pbind(\instrument, \kick, \dur, 4, \amp, 0.7);
~k1.play;

~pad = Pbind(\instrument, \synth, \amp, 1, \scale, Scale.minor, \degree, Prand([0,2,4,5,7,[2,4,5],[2.5,7]],inf), \octave, Pwrand([3,4],[0.7,0.3],inf), \harms, 60, \edur, 3, \dur, 4, \amp, 0);
~pad.play;

~pad2 = Pbind(\instrument, \synth, \amp, 1, \scale, Scale.minor, \degree, Prand([5,7,9,2,4,],inf), \octave, Pwrand([4,5],[0.7,0.3],inf), \harms, 50, \edur, 3, \dur, 4, \amp, 0);
~pad2.stop;

~k2 = Pbind(\instrument, \rotC, \dur, Pseq([Pseq([2],8),Pseq([1],inf)],inf), \amp, 1);
~k2.play;

~k3 = Pbind(\instrument, \kick2, \dur, Pseq([0.5,Pseq([2],inf)],inf), \amp, 1);
~k3.play;

~del_send = {Mix.ar([~g.ar, ~gd.ar, ~gu.ar])};

~del = {CombC.ar(~del_send.ar,0.4,0.7,3,SinOsc.kr(0.1).range(0.1,0.2))};
~del.play;

~flt = {RLPFD.ar(~del.ar, Lag.kr(LFNoise1.kr(0.1).range(200,300),0.3), SinOsc.kr(0.01).range(0.01,0.1),1,1.1)};
~flt.play;

~flt.stop(5);
~del.stop(30);
~pad2.stop(20);
~pad.stop(25);
~k2.stop(20);
~flt.stop(1);
~g.stop(10);




p.fadeTime=5;