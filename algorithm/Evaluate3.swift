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


func updateExpr(_ expr: String, _ pos: Int) -> String {

    // base case
    if expr.count == 1 {
        return expr
    }

    let firstIndex = expr.index(expr.startIndex, offsetBy: pos)
    let secondIndex = expr.index(expr.startIndex, offsetBy: pos+1)

    // e.g. '(2' -> expression start
    if(expr[firstIndex] == "(" && expr[secondIndex].isNumber) {
        // TODO calculate expression
        print("calc")
        return "x"
    }
    return expr.replacingOccurrences(of: expr[pos+1,pos+6], with: String(updateExpr(expr, pos+1)))
}

print(updateExpr("((2+2)+(1+3))",0))
print(updateExpr("(x+(1+3))",0))

(4+((1+2)*5))