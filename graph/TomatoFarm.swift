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

public final class TomatoFarm {
    var farmMap: [[Int]]
    var states: [[Int]]
    var days: [[Int]]
    var cnt: Int

    public init(M: Int , N: Int) {
        farmMap = [[Int]]()
        states = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
        days = [[Int]](repeating: [Int](repeating: 1000000, count: M), count: N)
        cnt = 0
    }

    public func addRow(row: [Int]) { 
        farmMap.append(row)
    }

    public func ripen(_ x:Int, _ y:Int) {
        states[y][x] = 1
        days[y][x] = 0
    }

    public func nextDay(_ x:Int, _ y:Int, _ nx:Int, _ ny:Int) {
        states[ny][nx] = 1
        days[ny][nx] = min(days[ny][nx], days[y][x] + 1)
        cnt += 1
    }

    public func getFarMapVal(_ x:Int, _ y:Int) -> Int {
        return farmMap[y][x]
    }

    public func getStatesVal(_ x:Int, _ y:Int) -> Int {
        return states[y][x]
    }

    public func getDaysVal(_ x:Int, _ y:Int) -> Int {
        return days[y][x]
    }

    public func resetStates() {
        states = [[Int]](repeating: [Int](repeating: 0, count: states[0].count), count: states.count)
    }

    public func countUnripe() -> Int {
        var cnt = 0
        for i in 0..<farmMap.count {
            for j in 0..<farmMap[0].count {
                if farmMap[i][j] == -1 {
                    continue
                }
                if states[i][j] == 0 {
                    cnt += 1
                }
            }
        }
        return cnt
    }

    public func getMinDay() -> Int {
        var minDay = 0
        for i in 0..<farmMap.count {
            for j in 0..<farmMap[0].count {
                if farmMap[i][j] == -1 {
                    continue
                }
                minDay = max(minDay, days[i][j])
            }
        }
        return minDay
    }
}

public func tomatoSolve() {
    struct Point {
        let x: Int
        let y: Int
    }
    let dx = [0, 0, 1, -1]
    let dy = [1, -1, 0, 0]

    func bfs(x: Int, y: Int, w: Int, h: Int, tf: inout TomatoFarm) {
        let q = Queue<Point>()
        q.enqueue(item: Point(x:x, y:y))
        tf.ripen(x, y)

        while !q.isEmpty() {
            let point = q.dequeue()!
            let x = point.x
            let y = point.y

            for i in 0..<4 {
                let nx = x + dx[i]
                let ny = y + dy[i]
                if nx >= 0 && nx < w && ny >= 0 && ny < h {
                    if tf.getFarMapVal(nx, ny) == -1 {
                        continue
                    }
                    if tf.getStatesVal(nx, ny) == 0 {
                        q.enqueue(item: Point(x: nx, y:ny))
                        tf.nextDay(x, y, nx, ny)
                    }
                }
            }
        }
    }

    let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
    let w = firstLine[0]
    let h = firstLine[1]

    var tf = TomatoFarm(M: w, N: h)
    for _ in 0..<h {
        let row = readLine()!.split(separator: " ").map { Int(String($0))! }
        tf.addRow(row: row)  
    }
    for x in 0..<w {
        for y in 0..<h {
            if tf.getFarMapVal(x, y) == 1{
                tf.resetStates()
                bfs(x: x, y: y, w: w, h: h, tf: &tf)
            }
        }
    }

    // no way to get all ripe tomatos
    if tf.countUnripe() > 0 && tf.cnt > 0 {
        print(-1)
        return
    }

    // already ripe
    if tf.countUnripe() > 0 && tf.cnt == 0 {
        print(0)
        return
    }

    print(tf.getMinDay())
}

tomatoSolve()