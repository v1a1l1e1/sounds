(
s = Server.local;

// extra safe
s.newBusAllocators;

s.options.sampleRate_(44100);
s.options.memSize_(2.pow(20)); //realtime memory size (~ 1GB)

p = ProxySpace.new(s, "live");
p.push;
p.makeTempoClock;
p.clock.tempo = 2;

r = {"Cleaning ... ".post; p.clear; p.pop; currentEnvironment.clear; "cleanup done".postln};

ServerBoot.add({if(currentEnvironment === p, {"ProxySpace running".postln}, {"ProxySpace not running".postln})});
ServerQuit.add(r);

s.waitForBoot({

	s.sync;
	("SynthDefs.scd").loadRelative;
	s.sync;
	StageLimiter.activate;
	"--- Setup completed ---".postln;

});
)