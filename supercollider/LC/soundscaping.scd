"Setup/Setup.scd".loadRelative;

~a1 = Pbind(\instrument, \g_play2, \buf, d["auto"][0], \dur, 0.25, \amp, 0.1, \rate, Prand([0.5,1,1.5],inf),\pan, Pwhite(-1.0,1.0), \d, Pseq([0.1,1,0.5,1.4],inf), \start, Pwhite(0,0.5), \end, Prand([0.5,0.6],inf));
~a1.stop;

~a2 = Pbind(\instrument, \g_play2, \buf, d["auto"][1], \dur, 4, \amp, 0.3, \start, Pwhite(0.0,0.6),\end, Pwhite(0.3,0.9), \d, 0.7, \rate, Pwhite(0.1,2.5));
~a2.play;

~a3 = Pbind(\instrument, \g_play2, \buf, d["auto"][2], \dur,2, \amp,1);
~a3.play;

~a4 = Pbind(\instrument, \g_play2, \buf, d["auto"][3], \dur,2, \amp,0.5, \rate, Pwhite(0.1,1.3), \pan, Pwhite(-1.0,1,inf));
~a4.play;

~bpf = {BPF.ar(Mix.ar([~pp.ar,~a1.ar]),LFNoise1.kr(0.2).range(200,500), LFNoise1.kr(0.4).range(0.01,0.1),1.5)};
~bpf.play;

~p1 = Pbind(\instrument, \g_play2, \buf, d["passi"][3], \dur,Pbjorklund2(3,8)/4, \amp,1, \rate, Pwhite(0.7,1.4), \pan, Pwhite(-1.0,1.0), \d, 1);
~p1.play;

~p2 = Pbind(\instrument, \g_play2, \buf, d["passi"][3], \dur,Pbjorklund2(3,8,inf,2)/4, \amp,1, \rate, Pwhite(0.1,0.5), \pan, Pwhite(-1.0,1.0), \d, 1);
~p2.play;

~pulse = {Pulse.ar([5,5.5],LFNoise1.kr(0.1).range(0.2,0.7))};
~pp = {Mix.ar([~p1.ar,~p2.ar]) * ~pulse.ar};
~pp.play;