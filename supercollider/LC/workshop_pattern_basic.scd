// Pattern di valori

(
var a, b;
a = Pseq([1, 2, 3], 2);
b = a.asStream;
7.do({ b.next.postln; });
)

(
var a, b;
a = Prand([1, 2, 3], 2);
b = a.asStream;
3.do({ b.next.postln; });
)

(
var a, b;
a = Pwrand([1, 2, 3], [0.7, 0.2, 0.1], 5);
b = a.asStream;
6.do({ b.next.postln; });
)

(
var a, b;
a = Pwhite(1,5,4);
b = a.asStream;
5.do({ b.next.postln; });
)


// Pattern di eventi

k = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, 1);
k = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, 0.5);
k = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pseq([1,0.5,0.25,0.5],inf));
k.play;

x = Pbind(\instrument, \sinfb, \scale, Scale.major, \ocatve, 4, \degree, Pseq([0, 4, 7, 11],inf), \dur, Prand([1,0.5],inf));
x.play;

