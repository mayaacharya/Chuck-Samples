//Final_Project_The_Paradox
//plucky.ck

[48, 50, 52, 53, 55, 57, 59, 60] @=> int scale[];


//an object for that plucky sound that makes me happy.
class Plucky{
    Impulse imp => ResonZ filt => dac;
    
    100 => filt.Q;
    500 => filt.gain;
    9000 => filt.freq;
    
    fun void freq(float f){
        f => filt.freq;
    }
    fun void setQ(float q){
        q => filt.Q => filt.gain;
    }
    fun void setGain(float g){
        g => imp.gain;  
    }
    fun void noteOn(float volume){
        volume => imp.next;  
    }
    
    fun float pitch(float freq){
        return (freq => filt.freq);
    }
    fun float pitch(int noteNumber){
        return (Std.mtof(noteNumber) => filt.freq);
    }
}

//new plucky object
Plucky s;

//have the object play notes sporatically 
while (true){
    s.pitch(12 + scale[Std.rand2(0,7)]);
    1 => s.noteOn;
    ((.50) + (0.25*Std.rand2(0,2)))::second => now;
    

}