("Setup/Setup.scd").loadRelative;

(
l = Prewrite(0,(
	0: #[0,0.25,0.5,0.25,0.5,0],
	0.5: #[0.5,0.5]
),20);

r = Prand([1,-1,0.5,-0.5,2,-2],inf);
)

p.clock.tempo = 100/60;
p.fadeTime=2;

(
~one = Pbind(\instrument, \g_play1, \buf, d["g"][0], \rate, r, \start, Pwhite(0,75)/100, \end, Pkey(\start)+Pwhite(0,10)/10,\reset, Pwhite(0,100)/100, \d, l, \trig, Pbjorklund2(Prand([3,5,7],inf),Prand([8,11,23],inf)), \amp, 0.5, \dur, l);
~one.play;

~two = Pbind(\instrument, \g_play2, \buf, d["g"][2], \rate, r, \start, Pwhite(0,5)/100, \end, Pkey(\start)+Pwhite(0,20)/20,\reset, Pwhite(0,100)/100, \d, l*4, \trig, Pbjorklund2(Prand([3,5,7],inf),Prand([8,11],inf)), \amp, 0.3, \dur, l);
~two.play;
)

(
~flt1 = {DFM1.ar(Mix.ar([~two.ar, ~one.ar]), LFNoise1.kr(0.5).range(100,10000), 0.01,mul:0.5)};
~flt2 = {RHPF.ar(Mix.ar([~two.ar, ~one.ar]), LFNoise1.kr(0.5).range(4000,8000), 0.01,0.35)};
~flt = {Mix.ar([~flt1.ar, ~flt2.ar])};
~flt.play;
)

~flt.free;

(
~noiseS = {WhiteNoise.ar(0.2)};
~noiseF = {RLPF.ar(~noiseS.ar, LFNoise1.kr(0.3).range(200, 600), 0.001, 0.2)};
~noiseF.play;
)


