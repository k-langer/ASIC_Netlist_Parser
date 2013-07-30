import std.stdio, std.container;
//import imports;

alias RedBlackTree !(DesignObject) nets;
alias RedBlackTree !(DesignObject) ports;
alias RedBlackTree !(DesignObject) instances;
alias RedBlackTree !(DesignObject) pins;



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
        n.insert(new Net(net_s));
    }
    public void addPort(string port_s) {
        p.insert(new Port(port_s));
    }
    public void addInstance(string instance_s) {
        i.insert(new Instance(instance_s));
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

class DesignObject {
   string name;
    DesignObject getObject() {
        return this;
    }
    override string toString() {
        return name;
    }
}

class Pin : DesignObject {
    
    nets netsOfPin;
    instances instancesOfPin; 

    this(string namex) 
    {
        name = namex;
    }
    override int opCmp (Object o)
	{
        if  (auto other = cast(Pin) o) {    
            return (name > other.name) - (name < other.name);
        }
		throw new Exception("Cannot compare non-designs");
	}
}

class Net : DesignObject{
    instances instancesOfNet;
    pins pinsOfNet;
    
    this(string namex) 
    {
        name = namex;
        instancesOfNet = new instances(); 
        pinsOfNet = new pins();
    }
    override int opCmp (Object o)
	{
        if  (auto other = cast(Net) o) {    
            return (name > other.name) - (name < other.name);
        }
		throw new Exception("Cannot compare non-designs");
	}
    
}
class Port : DesignObject{
    nets netsOfPort;
    instances instancesOfPort;
    
    this(string namex) 
    {
        name = namex;
        netsOfPort = new nets();
        instancesOfPort = new instances();
    }
    override int opCmp (Object o)
	{
        if  (auto other = cast(Port) o) {    
            return (name > other.name) - (name < other.name);
        }
		throw new Exception("Cannot compare non-designs");
	}
    
}
class Instance : DesignObject{
    nets netsOfInstance;
    ports portsOfInstance;

    this(string namex) 
    {
        name = namex;
        netsOfInstance = new nets();
        portsOfInstance = new ports();
    }
    override int opCmp (Object o)
	{
        if  (auto other = cast(Instance) o) {    
            return (name > other.name) - (name < other.name);
        }
		throw new Exception("Cannot compare non-designs");
	}
   
}
