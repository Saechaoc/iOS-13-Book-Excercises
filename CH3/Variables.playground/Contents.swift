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


/* Computed Variables
 These are variables that instead of having a value ie. var x = 1; they store a function ie. var x: Int { some function }
 
 Requirements:
 Variable must be declared with var
 Type must be declared explicitly
 Getter must return a value of the same type as the variable
 Setter takes in a parameter; by default parameter is called newValue; Setter is optional. Becomes read-only at that point tho.
 You can change the default parameter name by specifiying the parameter name. ie. set (someName) {}
 There must always be a getter
 
 
 Use Cases:
 Storing a simpler variable name representing a chain of methods on an object
 A computed variable that encapsulates a long calculation
 A storage method that acts as a gatekeeper on how the varaibles are get/set
 */

//Use Case 1.
import MediaPlayer

//Now when you call artWork, you're really calling MPContentItem.init().artwork
class Music {
    var mp : MPContentItem {
        MPContentItem.init()
    }
    
    var artWork : MPMediaItemArtwork? {
        self.mp.artwork
    }
}


/* Use Case 2. Facade for long calculation
 
 var authorOfItem : String? {
 guard let authorNodes =
 self.extensionElements(
 withXMLNamespace: "http://www.tidbits.com/dummy",
 elementName: "app_author_name")
 else {return nil}
 guard let authorNode = authorNodes.last as? FPExtensionNode
 else {return nil}
 return authorNode.stringValue
 }
 
 */

//Facade for storage

class ClampClass {
    private var _pp : Int = 0
    var pp: Int {
        get{
            self._pp
        }
        set {
            self._pp = max(min(newValue,5),0)
        }
    }
}


//If you have many types like this and want to use this many times over, create a property wrapper.
//A property wrapper is declared with @propertyWrapper and requires a wrappedValue property

@propertyWrapper struct Clamped {
    private var _val : Int = 0
    var wrappedValue: Int {
        get{
            self._val
        }
        set {
            self._val = max(min(newValue,5),0)
        }
    }
}


//Now to recreate class ClampClass using the wrapper

class NewClampClass {
    @Clamped var p : Int // p doesn't need to be initialized bc its computed & doesn't need a getter or setter bc the wrapper supplies them
    func toString() {
        print(p)
    }
}

let clampEx = NewClampClass()
clampEx.toString() //Initialized to 0
clampEx.p = 100
clampEx.toString() //Max value is 5

//Setter Observers: Functions that are called just before and just after other code sets a stored variable

var s = "Whatever" {
    willSet{
        print(newValue)
    }
    didSet{
        print(oldValue)
        
    }
}


//Lazy initialization: The initial value is not evaluated and assigned until running code accesses the variables value

//Singleton pattern
class MyClass {
    static let sharedSingleton = MyClass() //class has access to a single shared instance
}

let classReference = MyClass.sharedSingleton //perfectly legal reference


//Use case: 1. You have a lot of code, and don't want to run it until you absolutely need it.

//Use Case 2. You want to refer to an instance...
//Remember that you get a compile error with a computed variable if you use a function

//Practical Example:
class BrokenClass {
    lazy var val : Int = self.makeValue() // by making lazy no compile error
    func makeValue() -> Int {
        //makes up a value
        return Int.random(in: 1..<100)
    }
    func printVal() {
        print(val)
    }
}

var st : String = "string"
let ix = s.startIndex
let ix2 = s.index(ix,offsetBy:1)

var hey = Array("Hello")
print(hey)

let range = 1...3
for i in range {
    print(i)
}
st[...st.index(before: st.endIndex)]

//Swift has Tuples, but they are not compatible with Cocoa & Obj-C as are many other types...
//Able to swap values safely

//Side note: space matters in swift???
var s1 = "Hi"
var s2 = "World"
(s1,s2) = (s2,s1)

//Optionals: Basically they could be empty: nil

var stringMaybe = Optional("Howdy") //The optioinal keyword wraps the object
stringMaybe = Optional("New string") //It can only be modified with the same type; but will be automatically wrapped if the same type... ie.
stringMaybe = "Even Newer String" //This string is automaticallly wrapped into an optional

//The more practical way to create an optional is to use the ?
var stringOptional : String? = "Optional String"

//When using optionals as parameters you must unwrap the optional if it isn't expected
func optionalExpected(_ s: String?) {
    print(s) //implicit coercion of string
}

optionalExpected("String") ///unwrapped value wrapped implicitly

//Cannot do the oppposite: Must unwrap the optional before passing the parameters
func optionalNotExpected(s: String) {
    print(s)
}

//optionalNotExpected(s: stringMaybe) //Value of Optional must be unwrapped
/*
    When initially running the code below, stringMaybe had never been accessed
    I was unable to unwrap the value and got an error stating that "force-unwrap using '!' to abort execution if the optional value contains 'nil'"
    Perhaps since the value was never accessed, the compiler was not sure if it had a value, as a result I was unable to pass the string.
    Note to self: Likely bad style to unwrap unless you absolutely know without a doubt will compile/there is a value.
*/
stringMaybe = "Optional String" //adding just in case I want to run again and get the same error noted above
optionalNotExpected(s: stringMaybe!)

//One workaround might be to assign a value to the unwrapped value
var unwrappedString = ""
if stringMaybe != nil {
    unwrappedString = stringMaybe!
}
optionalNotExpected(s: unwrappedString)

//Optional Chaining is when you optionally unwrap the optional
stringMaybe?.uppercased() //returns nil if stringMaybe is nil but won't error out

//You can nest optionals : Likely incentive to recursively unwrap optional
let doubleOptional : String?? = "Hello"
print(doubleOptional!!)
