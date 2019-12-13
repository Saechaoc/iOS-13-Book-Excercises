class Dog {
    var name : String?
    var license: Int = 0
    
    init(name:String?) {
        self.name = name
    }
    
    init(license:Int) {
        self.license = license
    }
    
    convenience init(name: String?, license: Int) {
        self.init(name: name)
        self.init(license: license)
    }


}
let fido = Dog(name: "Luna",license: 1234)

class BetterDog {
    var name : String
    var license : Int
    
    init(_ name: String = "", _ license: Int = 0) {
        self.name = name
        self.license = license
    }
    
    func toString() {
        print("\(name) has the license \(license)")
    }
    
    func bark() {
        print("woof")
    }
    
    func speak() {
        self.bark()
        print("I'm \(self.name)")
    }
}

let luna = BetterDog("Luna", 1234)
luna.name == fido.name

class optionalEx {
    var name : String?
}

let cl = optionalEx() //This works because name is initialized to nil. Default initial values are required.

//An initializer can not refer to self until all instance properties have been initialized

struct Cat {
    var name : String
    var license: Int
    init(name:String, license:Int) {
        //meow() compile error called before properties are initialized
        self.name = name
        self.license = license
    }
    
    func meow() {
        print("meow")
    }
}

let kitty = Cat(name: "kitty", license: 1)

struct Digit {
    var number : Int
    var meaningOfLife : Bool //Delegating initializer cannot set a constant property
    init(number : Int) {
        self.number = number
        self.meaningOfLife = false
    }
    
    //Cannot refer to self until after the call to an init
    init() { //delegating initializer
        self.init(number: 42)
        self.meaningOfLife = true
    }
}

//Failable initializers: return an optional wrapping the new instance
//Nil is a signal for failure
class FailableDoggy {
    let name : String
    let license : Int
    
    init?(name: String, license: Int) {
        if name.isEmpty || license <= 0 {
            return nil
        }
        self.name = name
        self.license = license
    }
}
