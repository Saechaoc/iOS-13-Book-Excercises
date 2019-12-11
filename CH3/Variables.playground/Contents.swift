/*
    Variable types:
        1. Global
        2. Properties
            2a. Instance Properties
            2b. Static/Class Properties
        3. Local Variables
 */

//1.
var globalVar = "Some text"

//Properties live as long as the object does
class SomeClass {
    static let staticProperty = "Static Property"
    let instanceProperty = "Instance Property"
    
    func printInstanceProperty() {
        print("This is some classes \(self.instanceProperty)")
    }
}

class ClassThatRefersToSomeClass {
    func printSomeClassStaticProperty() {
        print("This is some classes \(SomeClass.staticProperty)")
    }
    
    func printSomeClassDogInstanceVariable() {
        let someClass = SomeClass()
        someClass.printInstanceProperty()
    }
}

let instanceVar = ClassThatRefersToSomeClass()
instanceVar.printSomeClassDogInstanceVariable() //2a
instanceVar.printSomeClassStaticProperty() //2b

class Dog {
    func printLocalVariable() {
        let localVariable = "local" //Local Variable
        print(localVariable) // *
    }
}

let dog = Dog()
dog.printLocalVariable()
//print(Dog.localVariable); Local Variable not visible to outer scope

//Variables are not truly variable; they conform to the initial type
//Best practice - include type
var x = 1 //implicit
var y : Double = 1.0 //explicit
var z : Double = 1 //Even though I gave it an int, converts it to double
z = 3 //Converts int to double
print(z)
//x = 2.0; errror
//x = "hello"; error

//Constants - let
let const = 1



/*
 When a variable’s address is to be passed as argument to a function, the variable must be declared and initialized beforehand, even if the initial value is fake.
 
var r : CGFloat = 0
var g : CGFloat = 0
var b : CGFloat = 0
var a : CGFloat = 0
c.getRed(&r, green: &g, blue: &b, alpha: &a)

 */

//Practical Example:
//class BrokenClass {
//    let val : Int = self.makeValue() // compile error
//    func makeValue() -> Int {
//        //makes up a value
//        return Int.random(in: 1..<100)
//    }
//    func printVal() {
//        print(val)
//    }
//}

class WorkingExampleClass {
    let val: Int = {
        return Int.random(in: 1..<100)
    }()
    
    func printVal() {
        print(val)
    }
}

let workingClass = WorkingExampleClass()
workingClass.printVal()

