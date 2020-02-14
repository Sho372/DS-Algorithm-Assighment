func evaluate(_ expression: String, _ pos: Int, _ array: [String]) -> Int {

    print("-----------------------------")
    print("eval start")
    print("expression: \(expression)")
    print("pos: \(pos)")
    print("-----------------------------")
    var currentArray = array

    // base case
    if expression.count == 1 {
        if let n = Int(expression) {
            print("hoge1")
            return n
        }
    }

    if expression.count-1 == pos {
        // calculate result using array and return it
        print(currentArray)
        return getResult(currentArray)
    }

    // recursive case
    // "(("
    if(expr1(expression, pos)) {
        print("hoge3")
        return evaluate(expression, pos+1, currentArray)
    } 
    // "(n"
    if (expr4(expression, pos)){
        if (expr2(expression, pos)) {
            // "(x+" or "(x*"
            print("hoge4")
            print("pos: \(pos)")
            let exprStart = expression.index(expression.startIndex, offsetBy: pos+1)
            let exprEnd = expression.index(expression.startIndex, offsetBy: pos+3)
            let expr = expression[exprStart...exprEnd]
            print("expr: \(expr)")
            let res = calculate(String(expr))
            print("res: \(res)")
            currentArray.append(String(res))
            //     |
            // ((1+3)+((1+2)*5))
            print("hoge5")
            return evaluate(expression, pos+3, currentArray)
        }
    }

    if(expr3(expression, pos)){
        // "n)"
        //     |
        // ((1+3)+((1+2)*5))
        print("hoge6")
        print("pos \(pos)")
        if(pos == expression.count-2) {
            // evaluate end
            return evaluate(expression, pos+1, currentArray)            
        }

        if(pos == expression.count-3) {
        print("hoge7")
            // evaluate end
            let aaa = expression.index(expression.startIndex, offsetBy: pos)
            let num = expression[aaa]
            currentArray.append(String(num))
            return evaluate(expression, pos+2, currentArray)            
        }

        print("hoge8")
        let opeIndex = expression.index(expression.startIndex, offsetBy: pos+2)
        let ope = expression[opeIndex]
        currentArray.append(String(String(ope)))
        //        |
        // ((1+3)+((1+2)*5))
        return evaluate(expression, pos+3, currentArray)
    }
    return -1
}

// ((
func expr1(_ expression: String, _ pos: Int) -> Bool {
    print("[Call expr1 function]")
    let first = expression.index(expression.startIndex, offsetBy: pos)
    let second = expression.index(expression.startIndex, offsetBy: pos+1)
    return (expression[first] == "(" && expression[second] == "(") 
}

// + or *
func expr2(_ expression: String, _ pos: Int) -> Bool {
    print("[Call expr2 function]")
    if (pos >= expression.count-2) {
        return false
    }
    let ope = expression.index(expression.startIndex, offsetBy: pos+2)
    return expression[ope] == "+"
}

// 'n)'
func expr3(_ expression: String, _ pos: Int) -> Bool {
    print("[Call expr3 function]")
    let first = expression.index(expression.startIndex, offsetBy: pos)
    let second = expression.index(expression.startIndex, offsetBy: pos+1)
    return ("0123456789".contains(expression[first]) && expression[second] == ")")
}


// (n
func expr4(_ expression: String, _ pos: Int) -> Bool {
    print("[Call expr4 function]")
    let first = expression.index(expression.startIndex, offsetBy: pos)
    let second = expression.index(expression.startIndex, offsetBy: pos+1)
    return (expression[first] == "(" && "0123456789".contains(expression[second]))
}


func calculate(_ expression: String) -> Int {
    print("[Call calc function]")
    let op_index = expression.index(expression.startIndex, offsetBy: 1)
    let op = expression[op_index]
    print("op: \(op)")
    
    let a = Int(String(expression.first!))
    let b = Int(String(expression.last!))
    print("a: \(a)")
    print("b: \(b)")

    if op == "+" {
        return a! + b!
    }
    if op == "*" {
        return a! * b!
    }
    return 0
}

func getResult(_ array: [String]) -> Int {

    var res:Int = 0
    if let a = Int(array[0]) {
        res = a
    }

        for i in 1..<array.count-1 {
            if(String(array[i]) == "+") {
                res += Int(String(array[i+1]))!
            }
            if(String(array[i]) == "*") {
                res *= Int(String(array[i+1]))!
            }
        }
    return res
}


let array:[String] = [] 
print(evaluate("7", 0, array)) // 4
print(evaluate("(2+2)", 0, array)) // 4
print(evaluate("((1+3)+((1+2)*5))", 0, array))
