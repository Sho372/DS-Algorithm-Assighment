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

class SushiReviewSolver {

    private var adjList:[[Int]] = [[Int]]()
    private var sushiRestaurant:[Int] = [Int]()
    private var sushiRestaurantPerm:[[Int]] = [[Int]]()
    private var minDist:[[Int]] = [[Int]]()

    public init () {}

    public func solve() {
        createAdjList()
        for i in 0..<adjList.count {
            bfs(from: i)
        }

        var minTime = (adjList.count-1) * adjList.count
        for p in sushiRestaurantPerm {
            let tmp = getMinTime(p)
            minTime = min(tmp, minTime)
        }
        print(minTime)
    }

    private func createAdjList() {

        let firstLine = readLine()!.split(separator: " ")
        let n = Int(firstLine[0])!
        let m = Int(firstLine[1])!

        let seconLine = readLine()!.split(separator: " ")
        for i in 0..<m {
            sushiRestaurant.append(Int(seconLine[i])!)
        }
        permutation()

        adjList = [[Int]](repeating: [], count: n)
        for _ in 0..<n-1 {
            let edge = readLine()!.split(separator: " ")
            let u = Int(edge[0])!
            let v = Int(edge[1])!
            adjList[u].append(v)
            adjList[v].append(u)
        }
    }

    private func bfs(from: Int) {
        var distance = [Int](repeating: -1, count: adjList.count)
        let q = Queue<Int>()
        q.enqueue(item: from)
        distance[from] = 0

        while !q.isEmpty() {
            let first = q.dequeue()!
            for v in adjList[first] {
                if distance[v] == -1 {
                    q.enqueue(item: v)
                    distance[v] = distance[first] + 1 
                }
            }
        }
        minDist.append(distance)
    }

    private func getMinTime(_ array: [Int]) -> Int {
        var m = 0
        for i in 0..<array.count-1 {
            m += minDist[array[i]][array[i+1]]
        }
        return m
    }

    private func permutationHelper(len: Int, _ chosen: inout [Int]) {
        if len == 0 {
            sushiRestaurantPerm.append(chosen)
        } else {
            for i in sushiRestaurant {
                if !chosen.contains(i) {
                    chosen.append(i)
                    permutationHelper(len: len-1, &chosen)
                    chosen.removeLast()
                }
            }
        }
    }

    private func permutation() {
        var chosen = [Int]()
        permutationHelper(len: sushiRestaurant.count, &chosen)
    }
}

let solver = SushiReviewSolver()
solver.solve()
