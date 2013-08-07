import std.stdio; 

import design; 
import parser; 
//import imports; 

int main(string argv[]){

    if (argv.length == 1) {
        writeln("ERROR: No input provided");
        return -1;
    }
    Design d = parseVFile(argv[1]);
    //d.print(d.getInstances());
    writeln(d.getInstance("U91"));
    return 0;
}
