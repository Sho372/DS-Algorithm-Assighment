import Glibc
import Foundation

extension String {
	subscript(index: Int) -> String {
		get {
			return String(self[self.index(startIndex, offsetBy: index)])
		}
		set {
			let startIndex = self.index(self.startIndex, offsetBy: index)
			self = self.replacingCharacters(in: startIndex..<self.index(after: startIndex), with: newValue)
		}
	}
	
	subscript(start: Int, end: Int) -> String {
		get {
			let startIndex = self.index(self.startIndex, offsetBy: start)
			let endIndex = self.index(self.startIndex, offsetBy: end)
			return String(self[startIndex..<endIndex])
		}
		set {
			let startIndex = self.index(self.startIndex, offsetBy: start)
			let endIndex = self.index(self.startIndex, offsetBy: end)
			self = self.replacingCharacters(in: startIndex..<endIndex, with: newValue)
		}
	}
}

func evaluate(_ expression: String, _ pos: Int) -> Int {

    var expr = expression

    print("-----------------------------")
    print("eval start")
    print("pos: \(pos)")
    print("expr: \(expr)")
    print("-----------------------------")

    // base case
    if expr.count == 1 {
        if let n = Int(expr) {return n} 
    }

    let firstIndex = expr.index(expr.startIndex, offsetBy: pos)
    let secondIndex = expr.index(expr.startIndex, offsetBy: pos+1)

    // e.g. '(2' -> expression start
    if(expr[firstIndex] == "(" && "0123456789".contains(expr[secondIndex])) {
        // TODO calculate expression
        print("calc")
        return 1
    }

    // recursive case
    print("expr \(expr)")
    if(expr.count == 5) {
        print("hoge1 \(expr)")
        return 5
    }

    if(expr.contains("(") && expr.contains(")")){
        print("[replace start]")
        if(expr.count == 5) {
            return 9
        } else {
            expr = expr.replacingOccurrences(of: expr[pos+1,pos+6], with: String(evaluate(expr, pos+1)))
            print("hoge2")
            print("[replace end]")
            return evaluate(expr, 1)
        }
    }
    print("hoge5")
    return 0
}

print(evaluate("7", 0)) // 7
print(evaluate("(2+2)", 0)) // 4
print(evaluate("((1+3)+((1+2)*5))", 0))





