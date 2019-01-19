("Setup/Setup.scd").loadRelative;

~f = {70};

(
~sin = {SinOscFB.ar([~f, ~f*1.01],0.7,0.3)};
~sin.play;
)

(
~lfn1 = {Splay.ar(Saw.ar(Array.fill(4, {LFNoise1.kr(0.3).range(~f, ~f*10).round(~f)}),0.3))};
~lfn1.play;
)

(
~f = {66.6};
~dChange = {SawDPW.ar([~f, ~f*1.02]*Demand.kr(Impulse.kr(p.clock.tempo*3),0, Dseq([1,8,2,7,3,6,4,5],inf)),SinOsc.kr(40),0.8)};
~dChange.play;
)

(
~k = Pbind(\instrument, \bplay, \buf, d["k"][2], \dur, Pbjorklund(Pwhite(1,15),16)/6, \amp, 1.01, \rate, Pwrand([1,1.2, 1.4,1], [0.6, 0.2, 0.1, 0.1],inf)*1.5);
~k2 = Pbind(\instrument, \bplay, \buf, d["sk"][0], \dur, 1, \amp, 1.01);
~k.play;~k2.play;
)

/*Noizzz */

(
~sinfb = Pbind(\instrument, \sinfb, \scale, Scale.minor, \octave, [3,4,5], \degree, Pseq([0,0,4,5],inf), \dur, Pbjorklund2(3,8)/4, \amp, 0.3, \fb, 0.1, \rel, 0.3);
~sinfb.play;
)

(
~feedback = {SinOsc.kr(0.1, -1,1).range(0, 20.0).poll(30)};
~sinfb.set(\fb, ~feedback);
~sinfb.play;
)