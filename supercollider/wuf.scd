
s.meter;
s.scope;


(
{
	g = LocalIn.ar(2) + Decay.ar(SinOsc.ar({SinOsc.kr(3+Dust.kr(1)).exprange(40, 90)}!2,{LinRand(0, 2*pi)},0.01),0.8, 0.4);
	LocalOut.ar(x = AllpassN.ar(g,0.1, 0.1,0.7, 0.6));
	x;
}.play;
)