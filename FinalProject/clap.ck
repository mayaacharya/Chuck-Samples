//Final_Project_The_Paradox
//clap.ck
SndBuf clap => dac;
me.dir(-1)+"/audio/clap_01.wav" => clap.read;

BPM tempo;

while (1)  {

    tempo.eighthNote => dur eighth;
    
    for (0 => int beat; beat < 8; beat++)  {
        if (Math.random2(0,7) < 3) {
            0 => clap.pos;
        }
        eighth => now;
    }
}    
    
