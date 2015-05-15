<<<"Four Score">>>;

Gain master;
Gain master2;
Pan2 panner;
Pan2 panner2;
time songStarts;
SndBuf intro;
SndBuf vocals;
SndBuf technoBeat;
SndBuf moreBeats;
SndBuf evenMore;
SndBuf clicker;
SndBuf clicker2;
TriOsc melody;
//array of Eb mixolydian scale
[51, 53, 55, 56, 58, 60, 61, 63] @=>  int mixo[];
//set time sequences, .25 for quarter note
.6::second => dur quarter;
4*quarter => dur whole;
2*quarter => dur half;

"FourScore" + ".wav" => string filename;

dac => Gain g => WvOut w => blackhole;

filename => w.wavFilename;

.5 => g.gain;

null @=> w;


//MAIN CHAIN
setup(); //this function assigns variables and such
introduction(); // this function sets up and executs intro
vocalStart();// sets up and executes intro vocals
makeSomeNoise(); //sets up and executes beats



//Methods
fun void setup(){
    //set masters and panning
    master =>  panner => dac;
    master2 =>  panner2 => dac;
    
    //get beginning time
    now =>  songStarts;
    
    
    //set sound buffers and oscillator
    1 => master.gain;
    intro => master;
    vocals => master2;
    technoBeat =>  master;
    moreBeats => master;
    evenMore => master;
    clicker => master;
    clicker2 => master;
    melody => NRev reverb => master;
    
    //set oscillator gain, frequency and reverb
    .4 => melody.gain;
    0 => melody.freq;
    .3 => reverb.mix;
    
    //set time sequences, .25 for quarter note
    .6::second => dur quarter;
    4*quarter => dur whole;
    2*quarter => dur half;
    
    //baseline name
    me.dir() + "/audio/" => string filename;
    
    
    
    filename + "kick_05.wav" => string technoName;
    filename + "clap_01.wav" => string moreName;
    filename + "stereo_fx_04.wav" => string introName;
    filename + "stereo_fx_03.wav" => string vocalName;
    filename + "hihat_02.wav" => string hihatName;
    filename + "kick_02.wav" => string clickerName;
    filename + "hihat_03.wav" => string clicker2Name;
    
    
    //array of file names
    [technoName, moreName, introName, vocalName, hihatName] @=> string name[];
    name[0] => technoBeat.read;
    name[1] => moreBeats.read;
    name[2] => intro.read;
    name[3] => vocals.read;
    name[4] => evenMore.read;
    
    //array of end positions
    [technoBeat.samples(), moreBeats.samples(), intro.samples(), vocals.samples(), evenMore.samples()] @=> int ends[];
    ends[0] => technoBeat.pos;
    ends[1] => moreBeats.pos;
    ends[2] => intro.pos;
    ends[3] => vocals.pos;
    ends[4] => evenMore.pos;
    
    
    clickerName => clicker.read;
    clicker.samples() => clicker.pos;
    
    clicker2Name => clicker2.read;
    clicker2.samples() => clicker2.pos;
    
    //array of dorian scale
    
    
    
    -0.5 => panner.pan;
    0.5 => panner2.pan;   
}

fun void introduction(){
    intro.samples() => intro.pos;
    -5 => intro.rate;
    2::second => now;
    0 => intro.pos;
    5=> intro.rate;
}

fun void vocalStart(){
    vocals.samples() => vocals.pos;
    -3 => vocals.rate;
    2.2::second => now;
    0 => vocals.pos;
    3 => vocals.rate;
}

fun void makeSomeNoise(){
    0 => int counter; //for beat counting
    1 => int i; //for knowing when to start things
    while(true){
        counter%11 => int beat; //modulo for beat counting
        if(beat == 0 || beat == 4 || beat == 7 || beat == 9){
            if(beat == 0){
                0 => vocals.pos;
                
                if(i == 5){
                    0 => panner2.pan;
                    2.4 => vocals.rate;
                }
                else if(i%2 == 0){
                    Std.rand2f(-1, 1) => panner2.pan; //randomly get pan
                    2.2 => vocals.rate;
                }
                else{
                    Std.rand2f(-1, 1) => panner2.pan; //randomly get pan
                    2 => vocals.rate;
                }
            }
            
            0 => technoBeat.pos;
            1 => technoBeat.rate;
            
        }
        if(i > 2){
            if((i > 3) && (beat == 5)){
                0 => evenMore.pos;
                Std.rand2f(0.2,1.0) => evenMore.rate;//randomly get rate   
            }
            if(beat == 8){
                0 => moreBeats.pos;
                Std.rand2f(0.5, 1.3) => moreBeats.rate;//randomly
            }
            if(i > 3){
                if(beat == 2){
                    (2)*Std.mtof(mixo[Std.rand2(0,7)]) => melody.freq; }
                    if(beat == 4)
                        (2)*Std.mtof(mixo[Std.rand2(0,7)]) => melody.freq;
                    if(beat == 7)
                        (2)*Std.mtof(mixo[Std.rand2(0,7)]) => melody.freq;
                }
                if(i > 5){
                    if(beat == 3 || beat == 5 || beat == 8){
                        (2)*Std.mtof(mixo[Std.rand2(0,7)]) => melody.freq;
                    }   
                }
                if(i > 4 &&(beat == 0 || beat == 3 || beat == 6 || beat == 9)){
                    Std.rand2f(.1, 1.2) => clicker.rate;
                    0 => clicker.pos;
                }
                if(i > 5 &&(beat == 2 || beat == 5 || beat == 8 || beat == 0)){
                    Std.rand2f(-1.2, -.1) => clicker2.rate;
                    
                    clicker2.samples() => clicker2.pos;
                }
                
            }
            if(i <= 4)
                quarter/2.25 => now;
            else if(i ==5)
                quarter/3.5 => now;
            else
                quarter/4 => now; 
            
            counter++;
            if(beat == 0) i++;
            
            //if it's been 30 seconds, end the song
            if(now - songStarts >= 30::second)
                break;
            //set melody off at end of each loop
            0 => melody.freq;
            
        }
        swell(0, melody.gain(), .05);
        swell2(0, vocals.gain(), .05);
        1::second => now;
    }
    
    fun void swell(float begin, float end, float grain){
        for(end => float j; j > begin; j-grain => j){ 
            j => melody.gain;
            0.01::second => now;
        }  
    }  
    
    fun void swell2(float begin, float end, float grain){
        for(end => float j; j > begin; j-grain => j){ 
            j => vocals.gain;
            0.01::second => now;
        }  
    }  
