//Final_Project_The_Paradox
//triangle.ck

//a triangle oscillator to play a happy melody
TriOsc noise =>NRev reverb => dac;
.1 => reverb.mix;
.2 => noise.gain;

[48, 50, 52, 53, 55, 57, 59, 60] @=> int scale[];


BPM tempo;
tempo.tempo(96);
while(true){
    Std.rand2(0,7) => int note;
    Std.rand2(0,1) => int octave;
   Std.mtof(scale[note] + (12*octave)) => noise.freq;
    .1::second => now;
    0 => noise.freq;
    (octave+1)*(tempo.eighthNote) => now;
}