//Final_Project_The_Paradox
// kick.ck
SndBuf kick => dac;
me.dir(-1)+"/audio/kick_01.wav" => kick.read;
.2 => kick.gain;

//conductor
BPM tempo;

while (1)  {
    //play
    tempo.quarterNote*2 => dur half;

    for (0 => int beat; beat < 4; beat++)  {
        0 => kick.pos;
        half => now;
    }
}    
    
