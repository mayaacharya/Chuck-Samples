//Final_Project_The_Paradox
//BPM.ck
public class BPM
{
    dur myDuration[];
    static dur quarterNote, eighthNote, sixteenthNote, thirtysecondNote;
    
    fun void tempo(float beat)  {
        
        60.0/(beat) => float SPB;
        SPB :: second => quarterNote;
        quarterNote*0.5 => eighthNote;
        eighthNote*0.5 => sixteenthNote;
        quarterNote*0.5 => thirtysecondNote;
        
        [quarterNote, eighthNote, sixteenthNote, thirtysecondNote] @=> myDuration;
    }
}

