//Final_Project_The_Paradox
//happyOsc.ck

Gain master => dac;
.1 => master.gain;

SinOsc happyKeys[4];

//conductor
BPM tempo;


//scale (given by assignment)
//[48, 50, 52, 53, 55, 57, 59, 60] @=> int scale[];
[45, 47, 49, 50, 52, 54, 56, 57] @=> int scale[];

//some oscillators to make happy chords
happyKeys[0] => master;
happyKeys[1] => master;
happyKeys[2] => master;
happyKeys[3] => master;

12 => int octave;

.2 => float volume;
0 => float volumeModifier;

volume => happyKeys[0].gain => happyKeys[1].gain => happyKeys[2].gain =>
happyKeys[3].gain;

//happy chords!
[48, 52, 55, 59] @=> int chordOne[];
[50, 53, 57, 59] @=> int chordTwo[];



0 => int c;

//spork chord player and volume modifier
spork ~ playChords();
spork ~ modChords();

while(true){
    1::second => now;   
}


//this function plays my happy chords
fun void playChords(){
    while(true){
        for(0 => int i; i < 4; i++){
            if(c%2 == 0){
                Std.mtof(chordOne[i] + octave) => happyKeys[i].freq;
            }
            else{
                Std.mtof(chordTwo[i] + octave) => happyKeys[i].freq;
                
            }
            
        }
        (24 * tempo.quarterNote) => now;
        c++;

    }
}

//this function modifies the volume of said chords based on the
//sin of a counter
fun void modChords(){
    while(true){
        Math.sin(volumeModifier) => volume;
        volume => happyKeys[0].gain => happyKeys[1].gain => happyKeys[2].gain =>
        happyKeys[3].gain;
        volumeModifier+.02 => volumeModifier;
        .1::second => now;
    }
}