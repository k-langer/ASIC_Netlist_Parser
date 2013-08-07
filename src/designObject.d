import std.stdio, std.container;

import abstractDesignObject;

//Top level for all placement objects in design

alias RedBlackTree !(DesignObject) nets;
alias RedBlackTree !(DesignObject) ports;
alias RedBlackTree !(DesignObject) instances;
alias RedBlackTree !(DesignObject) pins;

//Net attaches to pins and ports
class Net : DesignObject{
    instances instancesOfNet;
    pins pinsOfNet;

    this(string namex) 
    {
        type = "Net";
        name = namex;
        instancesOfNet = new instances(); 
        pinsOfNet = new pins();
    }
    public void addPin(Pin p) {
        pinsOfNet.insert(p);
    }
    public void addInstance(Net i) {
        instancesOfNet.insert(i);
    }
    public pins getPins() {
        return pinsOfNet;   
    }
    public instances getInstances() {
        return instancesOfNet;  
    }
}

//Port attaches to net
class Port : DesignObject{
    Net n; 
    this(Net nx, string namex) 
    {
        nx = n;
        type = "Port";
        name = namex;
    }
    public Net getNet() {
        return n;
    }
    
}

//Instance has pins. Is placed. 
class Instance : DesignObject{
    nets netsOfInstance;
    pins pinsOfInstance;

    this(string namex) 
    {
        type = "Instance";
        name = namex;
        netsOfInstance = new nets();
        pinsOfInstance = new pins();
    }
    public void addNet(Net n) {
        netsOfInstance.insert(n);
    }
    public void addPin(Pin p) {
        pinsOfInstance.insert(p);
    }
    public pins getPins() {
        return pinsOfInstance;
    }
    public nets getNets() {
        return netsOfInstance;
    }
}
class Pin : DesignObject {
    
    nets netsOfPin;
    Instance inst; 
    this(Instance i, string namex) 
    {
        type = "Pin";
        name = namex;
        inst = i;
        netsOfPin = new nets();
    } 
    public void addNet(Net n) {
        netsOfPin.insert(n);
    }
    public Instance getInstance() {
        return inst;
    }
    public nets getNets() {
        return netsOfPin;       
    }
}
