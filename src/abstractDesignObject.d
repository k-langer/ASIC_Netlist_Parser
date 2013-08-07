abstract class DesignObject {

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
    public pins getPins() {
        throw new Exception("Pins declared for this design"); 
    }
    public instances getInstances() {
        throw new Exception("Instnaces declared for this design");   
    }
    public nets getNets() {
        throw new Exception("Nets declared for this design");       
    }
    */
}
abstract class Net : DesignObject{
  
    public void addPin(Pin p);
    public void addInstance(Net i);
    //public T (T)getPins();
    //public T (T)getInstances();
}

//Port attaches to net
abstract class Port : DesignObject{
    public Net getNet();
}

//Instance has pins. Is placed. 
abstract class Instance : DesignObject{

    public void addNet(Net n);
    public void addPin(Pin p);
    //public T getPins(T)();
    //public T getNets(T)();
}
abstract class Pin : DesignObject {

    public void addNet(Net n);
    public Instance getInstance();
    //public T getNets(T)();
}
