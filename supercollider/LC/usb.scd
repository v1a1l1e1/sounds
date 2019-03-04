(SynthDef(\usb, {
	|out=0, freq=220, width = 0.5, amp=1, prob=0.5, atk=1, sus=1.5, rel=1.5|
	var sig, env;
	env = EnvGen.ar(Env([0,1,1,0], [atk, sus, rel], \sine), doneAction:2);
	sig = Disintegrator.ar(VarSaw.ar([freq, freq+1.1], rrand(0,pi), width,env),prob,0);
	Out.ar(out, sig*amp);

}).add;)


x = Pbind(\instrument, \usb, \freq, Prand((60..800).round(110), inf), \prob, Pwhite(0.01, 0.6), \amp, 0.5, \width, Pwhite(0.1, 0.6), \dur, Prand([1, 0.5, 2],inf));
x.play;

y = Pbind(\instrument, \usb, \freq, Prand((60 .. 200).round(110),inf), \prob, Pwhite(0.01, 0.2), \amp, 0.6, \width, Pwhite(0, 1.0), \dur, Pwhite(0.25, 2).round(0.125), \atk, 0.01, \sus, 0.2, \rel, 0.1);
y.play;

z = Pbind(\instrument, \usb, \freq, Prand((40 .. 150).round(55),inf), \prob, 0, \amp, 0.6, \width, Pwhite(0, 1.0), \dur, Pwhite(0.125, 0.5).round(0.125), \atk, 0.01, \sus, 0.1, \rel, 0.1);
z.play;
