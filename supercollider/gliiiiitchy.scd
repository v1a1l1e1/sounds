p = ProxySpace.new(s, \p1);
ProxySpace.all;

s.meter;
p.fadeTime=2;
p[\my_val]=20;
p[\out].play;
p[\in]={ Saw.ar([p[\my_val], p[\my_val]+rand(0,1.5)])*SinOsc.ar([120, 121.4])};
p[\in]= {Saw.ar([p[\my_val], p[\my_val]+rand(1,5)],0.5)*SinOsc.ar({LFNoise1.kr(2).exprange(120, 250)}!2)}
p[\out] = {Pan2.ar(AllpassN.ar(p[\in], 0.8, 0.4, 2),0)};
