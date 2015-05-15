//Final_Project_The_Paradox
// score.ck
BPM tempo;
tempo.tempo(96);


//add instruments and stuff
Machine.add(me.dir() + "/coolRight.ck") => int coolRightID;
31::second => now;
Machine.add(me.dir()+"/kick.ck") => int kickID;
2.0 * tempo.quarterNote => now;
Machine.add(me.dir()+"/happyOsc.ck") => int happyOscID;
4 * tempo.quarterNote => now;
Machine.add(me.dir()+"/plucky.ck") => int pluckyID;
4 * tempo.quarterNote => now;

Machine.add(me.dir()+"/snare.ck") => int snareID;
8.0 * tempo.quarterNote => now;
Machine.add(me.dir() + "/kick2.ck") => int kick2ID;

Machine.add(me.dir()+"/hat.ck") => int hatID;
8.0 * tempo.quarterNote => now;

Machine.add(me.dir() + "/triangle.ck") => int triangleID;
4 * tempo.quarterNote => now;

Machine.add(me.dir()+"/clap.ck") => int clapID;
Machine.remove(pluckyID);

8.0 * tempo.quarterNote => now;

96 => float newtempo;

//remove some instruments but not all
Machine.remove(clapID);
Machine.remove(hatID);
Machine.remove(kickID);
Machine.remove(snareID);

//slow it down
while (newtempo > 60.0) {
    newtempo - 20 => newtempo;
    tempo.tempo(newtempo);
    4.0 * tempo.quarterNote => now;
}

//remove instruments and such. I want the kick to kinda finish the 
//piece out so it ends last, a bit after all the other
//instruments

Machine.remove(triangleID);
Machine.remove(happyOscID);
2*tempo.quarterNote => now;
Machine.remove(kick2ID);

