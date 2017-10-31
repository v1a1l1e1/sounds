p = ProxySpace.push(s.boot);
p.fadeTime = 0.5;

//make a dedicated bus that will route the sound from the synth(s) to the ProxySpace node
e = Bus.audio(s, 2);

//add the SynthDef
(
SynthDef(\aTest, {
	arg freq = 250;
	var env, sig, amp = 0.3;
	
        //envelope with doneAction:2 that will free the synth once it's finished
	env = Env.perc(0.01, 5).ar(2);
	sig = SinOsc.ar(freq) * env * amp;
        //send to bus
	Out.ar(e, sig!2);
}).add;
)

~out.play;

//import sound from bus into ProxySpace
~out = {In.ar(e, 2)};


//make new Synths that get mixed to the same bus and overlap
Synth(\aTest, [\freq, rand(400, 800), \amp, 0.9]);