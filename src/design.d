import std.stdio, std.container;

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
