s.options.numBuffers = 1024 * 16;
s.options.memSize = 8192 *128;

(
s.waitForBoot{
	p=ProxySpace.push(s);
	p.makeTempoClock;
	p.clock.tempo = 2;

	Task({
		3.wait;
		"loading samples".postln;
		d = Dictionary.new;
		d.add(\foldernames -> PathName(thisProcess.nowExecutingPath.dirname +/+ "../samples_SC").entries);
		for (0, d[\foldernames].size-1,
			{arg i; d.add(d[\foldernames][i].folderName -> d[\foldernames][i].entries.collect({
				arg sf;
				Buffer.read(s,sf.fullPath);
			});
		)});

		"Loading synths".postln;
		("SynthDefs.scd").loadRelative;
		s.sync;
		"Loading snippets".postln;
		("Snippets.scd").loadRelative; // ctrl + `

		3.wait;

		StageLimiter.activate;
		"Setup done!".postln;
	}).start;
}
)