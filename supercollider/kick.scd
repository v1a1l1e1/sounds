(
x = SynthDef.new(\kick,
	{
		arg freq=60;
		var sig, env_sig, env_freq, amp=0.5;
		env_freq = EnvGen.kr(Env.perc(0.001,0.15,2.5));
		sig = SinOsc.ar(60*env_freq, pi*0.5);
		env_sig = EnvGen.kr(Env.perc(0.001, 0.4, curve:-1), doneAction:2);
		sig = sig*env_sig*amp;
		sig = Splay.ar(sig,2);
		Out.ar(0, sig);
	}
).add;
)
(
y = Pdef(
	\kick_pattern,
	Pbind(
		\instrument, \kick,
		\dur, Pseq([0.6], inf),
)).play(quant:1);
)

y.stop;
y.play;

(
Window.clear;
w = Window.new("pattern", Rect.new(0, 0, 180, 50));
w.front;
w.alwaysOnTop=true;

~start = Button.new(w,Rect(10, 10, 50, 20))
.states_([["start"]])
.action_({
	y.stop;
	y.play;
});


~stop = Button.new(w,Rect(100, 10, 50, 20))
.states_([["stop"]])
.action_({
	y.stop;
});
)
s.boot;