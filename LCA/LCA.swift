import Foundation

public final class Queue<E> : Sequence {
    /// beginning of queue
    private var first: Node<E>? = nil
    /// end of queue
    private var last: Node<E>? = nil
    /// size of the queue
    private(set) var count: Int = 0
    
    /// helper linked list node class
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    /// Initializes an empty queue.
    public init() {}
    
    /// Returns true if this queue is empty.
    public func isEmpty() -> Bool {
        return first == nil
    }
    
    /// Returns the item least recently added to this queue.
    public func peek() -> E? {
        return first?.item
    }
    
    /// Adds the item to this queue
    /// - Parameter item: the item to add
    public func enqueue(item: E) {
        let oldLast = last
        last = Node<E>(item: item)
        if isEmpty() { first = last }
        else { oldLast?.next = last }
        count += 1
    }
    
    /// Removes and returns the item on this queue that was least recently added.
    public func dequeue() -> E? {
        if let item = first?.item {
            first = first?.next
            count -= 1
            // to avoid loitering
            if isEmpty() { last = nil }
            return item
        }
        return nil
    }
    
    /// QueueIterator that iterates over the items in FIFO order.
    public struct QueueIterator<E> : IteratorProtocol {
        private var current: Node<E>?
        
        fileprivate init(_ first: Node<E>?) {
            self.current = first
        }
        
        public mutating func next() -> E? {
            if let item = current?.item {
                current = current?.next
                return item
            }
            return nil
        }
        
        public typealias Element = E
    }
    
    /// Returns an iterator that iterates over the items in this Queue in FIFO order.
    public __consuming func makeIterator() -> QueueIterator<E> {
        return QueueIterator<E>(first)
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return self.reduce(into: "") { $0 += "\($1) " }
    }
}

class LCASolver {

    private var adjList: [[Int]] = [[]]
    private var nodes: [[Int]] = [[Int]]()
    private var depth: [Int] = []
    private var parent: [Int] = []

    public init() {}

    public func solve() {
        createAdjList()
        bfs()
        lca()
    }

    private func createAdjList() {

        let n = Int(readLine()!)!
        adjList = [[Int]](repeating: [], count: n + 1)
        
        for _ in 0..<n-1 {
            let edge = readLine()!.split(separator: " ")
            let u = Int(edge[0])!
            let v = Int(edge[1])!
            adjList[u].append(v)
            adjList[v].append(u)
        }
    }

    private func bfs() {
        var visited = [Bool](repeating: false, count: adjList.count)
        depth = [Int](repeating: 0, count: adjList.count)
        parent = [Int](repeating: 0, count: adjList.count)
        let queue = Queue<Int>()
        queue.enqueue(item: 1)
        visited[1] = true
        depth[1] = 0

        while !queue.isEmpty() {
            let first = queue.dequeue()!
            for v in adjList[first] {
                if !visited[v] {
                    queue.enqueue(item: v)
                    parent[v] = first
                    depth[v] = depth[first] + 1  
                    visited[v] = true
                }
            }
        }
    }

    private func lcaHelper(p:Int, q:Int) {
        if p == q {
            print("output: \(p)")
        } else {  
            lcaHelper(p: parent[p], q:parent[q])
        }
    }

    private func lca() {
        let m = Int(readLine()!)!
        for _ in 0..<m {
            let pairs = readLine()!.split(separator: " ")
            var p = Int(pairs[0])!
            var q = Int(pairs[1])!
            while depth[p] != depth[q] {
                if depth[p] > depth[q] {
                    p = parent[p]
                } else {
                    q = parent[q]
                }
            }
            lcaHelper(p: p, q: q)
        }
    }

}

let lcaSolver =  LCASolver()
lcaSolver.solve()
