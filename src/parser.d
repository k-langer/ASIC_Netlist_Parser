import std.stdio, std.regex, std.container;

void parseFVile(string filename);




void main(string argv[]){
    Design d = parseVFile(argv[1]);
    d.print(d.getNets());
}

alias RedBlackTree !(net) nets;
alias RedBlackTree !(port) ports;
alias RedBlackTree !(instance) instances;
alias RedBlackTree !(pin) pins;
net * netp;
port* potp;
instance* instancep;
pin* pinp;


class Design {
    nets n;
    ports p;
    instances i;
    string name;
    this (string namex)
	{
        name = namex;
        n = new nets();
        p = new ports();
        i = new instances();
	}
    public void addNet(string net_s) {
        n.insert(new net(net_s));
    }
    public void addPort(string port_s) {
        p.insert(new port(port_s));
    }
    public void addInstance(string instance_s) {
        i.insert(new instance(instance_s));
    }
    public instances getInstances() {
        return i;
    }
    public nets getNets() {
        return n;
    }
    public ports getPorts() {
        return p;
    }
    public void print(T)(T t) {
        foreach (n ; t) {
            writeln(n);
        }
    }
    override int opCmp (Object o)
	{
        if  (auto other = cast(Design) o) {    
            return (name > other.name) - (name < other.name);
        }
		throw new Exception("Cannot compare non-designs");
	}
}
class pin {
    string name;
    //auto netsOfPin = new SList();

    this(string namex) 
    {
        name = namex;
    }
    override int opCmp (Object o)
	{
        if  (auto other = cast(pin) o) {    
            return (name > other.name) - (name < other.name);
        }
		throw new Exception("Cannot compare non-designs");
	}
}

class net {
    string name;
    //auto instancesOfNet = new SList();
    
    this(string namex) 
    {
        name = namex;
    }
    override int opCmp (Object o)
	{
        if  (auto other = cast(net) o) {    
            return (name > other.name) - (name < other.name);
        }
		throw new Exception("Cannot compare non-designs");
	}
    override string toString() {
        return name;
    }
}
class port {
    string name;
    //auto netsOfPort  = new SList();
    
    this(string namex) 
    {
        name = namex;
    }
    override int opCmp (Object o)
	{
        if  (auto other = cast(port) o) {    
            return (name > other.name) - (name < other.name);
        }
		throw new Exception("Cannot compare non-designs");
	}
    override string toString() {
        return name;
    }
}
class instance {
    string name;

    this(string namex) 
    {
        name = namex;
    }
    override int opCmp (Object o)
	{
        if  (auto other = cast(instance) o) {    
            return (name > other.name) - (name < other.name);
        }
		throw new Exception("Cannot compare non-designs");
	}
    override string toString() {
        return name;
    }
}


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
                            d.addPort(m.captures[1]);
                        }
                            
                    }
            //NET
                } else if ( select == "wire" ) {
                    //writeln("net"); 
                    foreach (pinNet; match(l,regex(r"(\w*),","gm"))){
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
                        }
                    }
                    //Get all pins and attached nets
                    foreach (pinNet; match(l,regex(r"\.(\w*)\(([\w\[\]\d]*)\)","gm"))){
                        //writeln("\t" , pinNet.captures[1] , " " , pinNet.captures[2] );
                        
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

