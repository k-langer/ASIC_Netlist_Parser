import std.stdio; 

import design; 
import abstractDesignObject;
import parser; 
import UI; 

//import imports; 

int main(string argv[]){

    if (argv.length == 1) {
        writeln("ERROR: No input provided");
        return -1;
    }
    Design d = parseVFile(argv[1]);
    //d.print(d.getInstances());
    writect(d.getNet("N96").getPins());
    return 0;
}
