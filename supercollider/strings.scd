(
{
	var n = 8;
	Mix.ar(
		Pan2.ar(
			CombL.ar(
				Dust.ar(1.dup(n),0.3), //in
				0.01,//maxDelayTime
				{0.004.rand+0.003}.dup(n), //delayTime
				4, //decayTime
			),
			{1.0.rand2}.dup(n) //pan position
		)
	)
}.scope(2, zoom:4);
)

(
SynthDef(\strings, {
	|maxDelayTime=0.01, dlyO=0.003,decayTime=4|
	var n=8;
	var sig = Mix.ar(Pan2.ar(
		CombL.ar(
		Dust.ar(1.dup(n),0.3),
		maxDelayTime,
			{rand(0.004)+dlyO}.dup(n),
		decayTime
		) //fine comb
	),//fine pan
	{1.0.rand}.dup(n));
	Out.ar(0, sig*EnvGen.kr(Env([0, 1, 1, 0], [0.001, 2, 3], \sine), doneAction:2))
}).add;
)
(
f=Pbind(
	\instrument, \strings,
	\dur, 2.5,
).play;
)