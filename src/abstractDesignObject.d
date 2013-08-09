
import std.container;
alias RedBlackTree !(DesignObject) nets;
alias RedBlackTree !(DesignObject) ports;
alias RedBlackTree !(DesignObject) instances;
alias RedBlackTree !(DesignObject) pins;


abstract class DesignObject{
    
    string name;
    string type; 
    bool isPlaced = false; 
    bool isFixed = false; 
    
    bool instantiated = true;    
    DesignObject getObject() {
        return this;
    }
    string getName() {
        return name;
    }
    bool isInst() {
        return instantiated;
    }
    string getObjectType() {
        return type;
    }
    void setInst(bool instantiatedx) {
        instantiated = instantiatedx;
    }
    override string toString() {
        return name;
    }
    override int opCmp (Object o)
	{
        if  (auto other = cast(DesignObject) o) {   
            if (other.getObjectType() == type) {
                return (name > other.name) - (name < other.name);
            }
        }
		throw new Exception("Cannot compare non-designs");
	}
    

    /*
    public instances getInstances() {
        throw new Exception("Instnaces declared for this design");   
    }
    public nets getNets() {
        throw new Exception("Nets declared for this design");       
    }
    */
}
abstract class Net : DesignObject{
  
    abstract void addPin(Pin p);
    abstract void addInstance(Net i);
    abstract pins getPins();
    abstract instances getInstances();
}

//Port attaches to net
abstract class Port : DesignObject{
    abstract Net getNet();
}

//Instance has pins. Is placed. 
abstract class Instance : DesignObject{

    abstract void addNet(Net n);
    abstract void addPin(Pin p);
    abstract pins getPins(T)();
    abstract nets getNets(T)();
}
abstract class Pin : DesignObject {

    abstract void addNet(Net n);
    abstract Instance getInstance();
    abstract nets getNets();
}
