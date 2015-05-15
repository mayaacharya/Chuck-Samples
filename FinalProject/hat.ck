//Final_Project_The_Paradox
//hat.ck
SndBuf hat => dac;
me.dir(-1)+"/audio/hihat_02.wav" => hat.read;

//conductor
BPM tempo;

while (1)  {
    // update beat
    tempo.eighthNote => dur eighth;
    
    // play measure
    for (0 => int beat; beat < 8; beat++)  {
        //(but not too much hihat)
        if (beat == 4 || beat == 7) {
            0 => hat.pos;
        }
        eighth => now;
    }
}    
    
