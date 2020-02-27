//
//  UF.swift
//  SwiftAlgorithmsDataStructures
//
//  Created by Derrick Park on 2/24/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

/// The UF struct represents a union-find (disjoint sets) data structure
/// It supports **union** and **find** operations, along with methods for
/// determining whether two nodes are in the same component and the total
/// number of components.
/// This implementation uses weighted quick union (by size or rank) with
/// full path compression.
/// Initializing a data structure with **n** nodes takes linear time.
/// Afterwards, **union**, **find**, and **connected** take logarithmic time
/// (in the worst case) and **count** takes constant time.
/// Moreover, the amortized time per **union**, **find**, and **connected** operation
/// has inverse Ackermann complexity (which is practically < 5 for 2^(2^(2^(2^16))) - undefined number).
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

var uf = UF(10)
print("count \(uf.count)")
print(uf.connected(4, 3))
uf.union(4, 3)
print(uf.connected(4, 3))
uf.union(3, 8)
uf.union(9, 4)
uf.union(2, 1)
print(uf.connected(0, 7))
print(uf.connected(8, 9))
uf.union(5, 0)
uf.union(7, 2)
uf.union(6, 1)
uf.union(1, 0)
print(uf.connected(0, 7))
print("count \(uf.count)")

print(uf.find(1))
print(uf.find(6))
print(uf.find(2))

print(uf.find(8))
print(uf.find(9))
print(uf.find(4))