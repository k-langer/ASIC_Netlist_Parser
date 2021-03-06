import std.stdio, std.regex, std.conv;
import design; 
//import imports;

void parseFVile(string filename);

Design parseVFile(string filename) {

    Design d;
	string[] lines;
	foreach(str; File(filename).byLine()) {
		lines ~= str.idup;
	}
    
	//auto EOF_reg = regex(r";");
	
	int i = 0;
    bool EOF = true;
    string heir;
    string select;
    bool isModule = false;
    bool captured = false;
    string instance; 
    //line by line structural verilog parser
	foreach(string l; lines) {

            //ENDMODULE
            if (match(l,r"endmodule")) {
                break;
            } 
            //START MODULE
            else if (auto a = match(l,r"module\s(\w*)\s")) {
                heir = a.captures[1];
                d = new Design(heir);
                if (match(l,r";")){isModule = false;}else{isModule = true;}
                continue;
            } else if (isModule) {
                if (match(l,r";")){isModule = false;}else{isModule = true;}
                continue;
            }
            auto a = match(l,r"\w*\b");
            if (a) {
                if (EOF) {
                    select = a.hit();
                }
            //PORT
                if (select == "input" || select == "output" ) {
                    //writeln("port");
                    bool endBus;
                    int width = 1;
                    foreach(m ; match(l,regex(r"([\w:]*)[,\];]","gm"))) {
                        //check multi-width bus
                        auto bus = match(m.hit(),r"(\d*):(\d*)");
                        
                        if ( bus ) {
                            endBus = false;
                            width = std.conv.to!int(bus.captures[1])-std.conv.to!int(bus.captures[2]) + 1;
                        } else { 
                            if (endBus) {
                                width = 1;
                            }
                            endBus = true;
                        } 
                        if (endBus) {
                            //writeln("\t" , m.captures[1] , " " , width);
                            if (width == 1 ) {
                                auto n = d.addNet(m.captures[1]); 
                                d.addPort(n,m.captures[1]);
                            } else {
                                for (int ic = 0; ic < width; ic++) {
                                    auto n = d.addNet(m.captures[1] ~ "[" ~ to!string(ic) ~ "]"); 
                                    d.addPort(n,m.captures[1]);
                                }
                            }
                        }
                            
                    }
            //NET
                } else if ( select == "wire" ) {
                    //writeln("net"); 
                    foreach (pinNet; match(l,regex(r"(\w*)[,;]","gm"))){
                        //writeln("\t" , pinNet.captures[1]);
                        d.addNet(pinNet.captures[1]);
                    }

                } 
            //INSTANCE            
                else {
                    
                    if (!captured) {
                        //writeln(select);
                        captured = true;
                        //Get instance name, broken if on seperate line from cell name
                        if ( auto name_regx = match(l,r"\b\w*\b\s\\?([\w\[\]\d]*)") ) {
                            //writeln(name_regx.captures[1]);
                            d.addInstance( name_regx.captures[1]);
                            instance = name_regx.captures[1];
                        }
                    }
                    //Get all pins and attached nets
                    auto inst = d.getInstance(instance);
                    //writeln(inst);
                    foreach (pinNet; match(l,regex(r"\.(\w*)\(([\w\[\]\d]*)\)","gm"))){
                        //writeln("\t" , pinNet.captures[1] , " " , pinNet.captures[2] );
                        //writeln(inst);                        
                        auto p = d.getPin(inst,pinNet.captures[1]);
                        auto n = d.getNet(pinNet.captures[2]);
                        //writeln(pinNet.captures[2] , " " , n , "\n");
                        p.addNet(n); 
                        n.addPin(p);
                        inst.addPin(p);
                    }
                    
                }
                
            }  
            //EOF
            if (match(l,r";")){
                EOF = true;
                captured = false;
            }else{
                EOF = false;
            }
           	
	}
    return d;
    
}

