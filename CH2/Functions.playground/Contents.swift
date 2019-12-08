//Regular Function Calls
func sum (_ x: Double, _ y: Double) -> Double {
    return x + y
}

let sumAmt = sum(1.0,2.0)
print(sumAmt)

//Void Function Calls
func voidF1() {
    voidFunction()
}

func voidF2() -> Void {
    voidF1()
}

func voidFunction() -> () {
    print("does nothing")
}

voidF1()
voidF2()
voidFunction()

/* Function Signatures
 (Int, Int) -> Int
Basically a way to describe functions - defines input and output
*/

//Function Overloading
// You can declar the same function, but with different types. Works with different return types too.

func say(_ val: Double) {
    print("Double Function 1")
}

func say(_ val: Int) {
    print("Int Function 2")
}

say(1.0)
say(2)

//When the functions are the same, but have different return types the functions must be used in a way that disambiguates the context
func returnTypes(_ val: Int) -> String {
    return "one"
}


func returnTypes(_ val: Int) -> Int {
    return 1
}

print(returnTypes(2) + " this is the first function")
print("This is the second function:", returnTypes(2) + 2)


/* Variadric Parameters
 “This means that the caller can supply as many values of this parameter’s type as desired,
 separated by a comma; the function body will receive these values as an array.
*/

func sayStrings(_ arrayOfStrings:String ...) {
    for s in arrayOfStrings { print(s) }
}

sayStrings("String 1", "String 2", "String 3", "String 4")

/* Modifiable Parameters
 * When declaring parameters they are declared using let so you can't modify them.
 */

func modEx(someVal: Bool) -> Bool {
    //someVal = true Compile Error
    var someVal = someVal
    someVal = !someVal
    
    if someVal {
        return true
    }
    return false
}

print(modEx(someVal: true))
print(modEx(someVal: false))

//The problem with this approach is that the local value is changed, not the original value

func changeVal(val: [Int]) -> () {
    var val = val
    val[0] = 2
}

var arr = [Int]()
arr.append(1)

print (arr)
changeVal(val: arr)
print(arr)

//We can change the original value if we use inout as the parameter

func changeVal2(from val: inout [Int]) -> () {
    val[0] = 2
}

print (arr)
// we pass the address of the value using the ampersand
changeVal2(from: &arr)
print(arr)

/* A function can be used wherever a value can be used
* Valid Examples:
 assigned to a variable
 passed as an argument in a function call;
 a function can be returned as the result of a function
*/

//Ex. 1
print("Going to run the void function which does nothing")
var _ = voidFunction()


func exFunc(_ function: () -> ()) {
    function()
}

//The method signature of 'function' is an int function
func intFunc(_ int: Int) -> Int {
    return int
}

func exFunc(_ function: (Int) -> (Int),_ int: Int) -> Int {
    return function(int)
}

print(exFunc(intFunc,1))

//More useful example
func capitalize(s: String) -> String {
    let capArray = Array(s)
    var returnStr = ""
    var isFirstChar = true
    
    for element in 0..<capArray.count {
        let char = capArray[element]
        
        if isFirstChar && char != " " {
                returnStr += char.uppercased()
                isFirstChar = false
        }else if char == " " {
            returnStr += " "
            isFirstChar = true
        }else {
            returnStr += String(char)
        }
    }
    return returnStr
}

//Test function
var str="hello world i hope you  enjoy"
print(capitalize(s: str))

func applyToString(_ f: (String) -> (String), _ s: String) -> String {
    return f(s)
}

applyToString(capitalize, str)

/* Real World Example

let size = CGSize(width:45, height:20)
UIGraphicsBeginImageContextWithOptions(size, false, 0)
let p = UIBezierPath(
    roundedRect: CGRect(x:0, y:0, width:45, height:20), cornerRadius: 8)
p.stroke()
let result = UIGraphicsGetImageFromCurrentImageContext()!
UIGraphicsEndImageContext()

 This is boilerplate code and needs to be run many times... refactor into
 
 image of size takes in two parameters: size, and a function speicifying what to draw
 The function first creates an image context
 Then draws into that context using the function passed in
 Extracts the image and ends the image context and returns the extracted image
 
 func imageOfSize(_ size:CGSize, _ whatToDraw:() -> ()) -> UIImage {
     UIGraphicsBeginImageContextWithOptions(size, false, 0)
     whatToDraw()
     let result = UIGraphicsGetImageFromCurrentImageContext()!
     UIGraphicsEndImageContext()
     return result
 }
 
 func drawing() {
     let p = UIBezierPath(
         roundedRect: CGRect(x:0, y:0, width:45, height:20),
         cornerRadius: 8)
     p.stroke()
 }
 
 //f(x) takes in size and drawing and returns a UIImage
 let image = imageOfSize(CGSize(width:45, height:20), drawing)
*/

// We can use typealises so when functions are passed to other functions we can use names
// Purpose = code easier to read

typealias voidTypeAlias = () -> ()

//Notice how the name represents the typealias naming convention
func doStuff(_ f: voidTypeAlias) {
    f()
}

//Annonymous Functions
//let x = { () -> String in
//    return "Hello"
//}
