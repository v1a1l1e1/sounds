s.boot;
// Move the mouse left/right to see the gradation of the effect.
// Move up or down to choose mode. The modes sound very different.
(
x = {
    var sig, mode;
    sig = [SinOsc.ar, PinkNoise.ar].mean;
	    mode = Lag.kr(LFNoise1.kr(0.3).range(1,2).round(1));
	WaveLoss.ar(sig, Lag.kr(LFNoise0.kr(0.1).range(0, 40),0.2), 40, mode: mode, mul: 0.1);
}.play;
)
x.free;

b = Buffer.read(s,Platform.resourceDir +/+"sounds/a11wlk01.wav"); // remember to free the buffer later.
(
~y = {
    var sig, mode, woo;
    sig = PlayBuf.ar(1, b.bufnum, BufRateScale.kr(b.bufnum) * 0.75, startPos: 92898, loop: 1);
    woo = {
        WaveLoss.ar(sig,
            EnvGen.kr(Env.new([199, 199, 150, 150, 199, 250], [20, 40, 60, 60, 100]), doneAction:2)
            + (FSinOsc.kr(0.2 + XLine.kr(0.001, [1.3, 1.7], 90), 0, 50) * XLine.kr(0.00000001, 1, 60))
            ,
            200, mode: 2, mul: 0.4);
    }.dup;
    woo = (woo * 0.9) + (woo.reverse * 0.1);
}.play;
)
y.free;
b.free;
