//Final_Project_The_Paradox
//kick2.ck
BPM tempo;
SndBuf kick => dac;
.4 => kick.gain;
me.dir(-1) + "/audio/kick_05.wav" => kick.read;

while(true){
 0 => kick.pos;
 tempo.quarterNote*3 => now;   

}