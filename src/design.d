import std.stdio, std.container, std.range;

import designObject;



class Design {
    alias RedBlackTree !(Net) nets;
    alias RedBlackTree !(Port) ports;
    alias RedBlackTree !(Instance) instances;
    alias RedBlackTree !(Pin) pins;
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
   
    public Net addNet(string)(string net) {
        auto ne = getNet(net);
        if(!ne) {
            ne = new Net(net);
            n.insert(ne);
        }
        return ne;
    }
    public Port addPort(Net n, string port) {
        auto po = getPort(port);
        if(!po) {
            po = new Port(n, port);
            p.insert(po);
        }
        return po;
    }
     public Instance addInstance(string)(string instance) {
        auto ins = getInstance(instance);
        if(!ins) {
            ins = new Instance(instance);
            i.insert(ins);
        }
        return ins;
    }

    /*
    public void addInstance(Instance)(Instance instance) {
        if(!instance.isInst()) {
            i.insert(instance);
        }
    } 
    public void addPort(Port)(Port port) {
        if(!port.isInst()) {
            p.insert(port);
        }
    }
    public void addNet(Net)(Net net) {
        if(!net.isInst()) {
            n.insert(net);
        }
    }
    */
    
    public Net getNet(string name) {
        auto tnet = new Net(name);
        if (tnet in n) {
            return n.equalRange(tnet).front();
        }
        return null;
    }
    public Instance getInstance(string name) {
        auto tins = new Instance(name);
        if (tins in i) {
            return i.equalRange(tins).front();
        }
        return null;
    }
    public Port getPort(string name) {
        auto tpor = new Port(null, name);
        if ( tpor in p ) {
            return p.equalRange(tpor).front();
        }
        return null;
    }
    public Pin getPin(Instance ins, string name) {
        if (ins) {
            auto tpin = new Pin(ins,name); 
            ins.addPin(tpin);
            return tpin;
        }
        throw new Exception("Invalid instance name given to pin creator");
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


