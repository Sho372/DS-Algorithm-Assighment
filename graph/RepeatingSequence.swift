import Foundation

public struct UF {
    /// parent[i] = parent of i
    private var parent: [Int]
    /// size[i] = number of nodes in tree rooted at i
    private var size: [Int]
    /// number of components
    private(set) var count: Int
    
    /// Initializes an empty union-find data structure with **n** elements
    /// **0** through **n-1**.
    /// Initially, each elements is in its own set.
    /// - Parameter n: the number of elements
    public init(_ n: Int) {
        self.count = n
        self.size = [Int](repeating: 1, count: n)
        self.parent = [Int](repeating: 0, count: n)
        for i in 0..<n {
            self.parent[i] = i
        }
    }
    
    /// Returns the canonical element(root) of the set containing element `p`.
    /// - Parameter p: an element
    /// - Returns: the canonical element of the set containing `p`
    public mutating func find(_ p: Int) -> Int {
        var p = p
        // TODO
        while parent[p] != p {
            p = parent[p]
        }
        return p
    }
    
    /// Returns `true` if the two elements are in the same set.
    /// - Parameters:
    ///   - p: one elememt
    ///   - q: the other element
    /// - Returns: `true` if `p` and `q` are in the same set; `false` otherwise
    public mutating func connected(_ p: Int, _ q: Int) -> Bool {
        // TODO
        return find(p) == find(q)
    }
    
    /// Merges the set containing element `p` with the set containing
    /// element `q`
    /// - Parameters:
    ///   - p: one element
    ///   - q: the other element
    public mutating func union(_ p: Int, _ q: Int) {
        // TODO
        let rootP = find(p)
        let rootQ = find(q)

        if rootP == rootQ {return}
        if size[rootP] < size[rootQ] {
            parent[rootP] = rootQ
            size[rootQ] += size[rootP]
        } else {
            parent[rootQ] = rootP
            size[rootP] += size[rootQ]
        }
        count -= 1
    }
}


class RepeatingSequenceSolver {

    var uf:UF
    var D:[Int]

    public init(){
        uf = UF(400000)
        D = [Int]()
    }

    public func solve() {
        let firstLine = readLine()!.split(separator: " ")
        var A = Int(firstLine[0])!
        let p = Int(firstLine[1])!
        D.append(A)
        while !uf.connected(A, next(A ,p)) {
            D.append(next(A ,p))
            uf.union(A, next(A ,p))
            A =  next(A ,p)
        }
        let nextVal = next(A, p)
        var index = 0
        while nextVal != D[index] {
            index += 1
        }
        print(index)
    }

    private func next(_ A: Int, _ p: Int) -> Int {
        let numStr = String(A)
        var sum = 0
        for d in numStr {
            sum += Int(pow(Double(String(d))!, Double(p)))
        }
        return sum
    }
}

let solver = RepeatingSequenceSolver()
solver.solve()
