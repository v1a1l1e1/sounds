("./Setup_samples.scd").loadRelative

DDWSnippets.put("kick", "~k = Pbind(\\instrument,\\player,\\buf,d[\\bd_][4],\\dur,##1##,\\amp, 1.5,);");

(
~k.play;
~k1.play;
~k2.play;
~sn.play;
)

p.clock.tempo = (114/60) ;
(
~k1 = Pbind(\instrument, \player,\buf, d[\bd_][4],\amp, 1.5, \dur, 1);
~k1.play;
~k2 = Pbind(\instrument, \player,\buf, d[\bd_][3],\amp, 1, \dur, Pwrand([0.75, Pbjorklund(12, 16, 5,1)], [0.1, 0.9], inf));
~k2.play;
~sn = Pbind(\instrument, \player, \buf,d[\sd_][0],\amp, 1, \dur, Pwrand([0.75,0.5], [0.65, 0.45], inf));
~sn.play;
)

~k1.stop;
~k2.stop;
~sn.stop;

ProxyMixer