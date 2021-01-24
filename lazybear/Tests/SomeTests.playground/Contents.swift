import UIKit

func returnDouble() -> (String, String) {
    let a = "Hello"
    let b = "world"
    
    return (a, b)
}

let (a, b) = returnDouble()
print(a)
print(b)
