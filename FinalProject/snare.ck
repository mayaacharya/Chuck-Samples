//Final_Project_The_Paradox
// snare.ck
SndBuf snare => dac;
me.dir(-1)+"/audio/snare_01.wav" => snare.read;
2.0 => snare.gain;
snare.samples() => snare.pos;

//conductor
BPM tempo;

while (1)  {
    tempo.quarterNote => dur quarter;

    quarter => now;
    0 => snare.pos;
    2.0*quarter => now;
    0 => snare.pos;
    quarter/4.0 => now;
    0 => snare.pos;
    3.0*quarter/4.0 => now;
}    
    
