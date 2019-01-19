(
SynthDef("help-SendTrig",{
    SendTrig.kr(Dust.kr(1.0),0,0.9);
}).add;

SynthDef("sine", {Out.ar(0,SinOsc.ar(220!2,0, EnvGen.kr(Env.perc,doneAction:2)))}).add;

// register to receive this message
o = OSCFunc({ arg msg, time;
    [time, msg].postln;
	Synth("sine");
},'/tr', s.addr);
)

Synth("help-SendTrig");

o.free;