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

func bridge() {
    struct Point {
        let x: Int
        let y: Int
    }
    let dx = [0, 0, 1, -1]
    let dy = [1, -1, 0, 0]

    var countryMap = [[Int]]()
    var island = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 10)
    var edgeOfIsland = [[Point]](repeating: [], count: 4)
    var bridgeDistance = [Int]()
    var minDistance = 10000

    func bfs(x: Int, y: Int, id: Int, n: Int) {
        let q = Queue<Point>()
        q.enqueue(item: Point(x: x, y: y))
        island[x][y] = id

        while !q.isEmpty() {
            let point = q.dequeue()!
            let x = point.x
            let y = point.y
            // check 4 directions
            for i in 0..<4 {
                let nx = x + dx[i]
                let ny = y + dy[i]
                // check the bounds
                if nx >= 0 && nx < n && ny >= 0 && ny < n {
                    // check if there's a house and not yet marked in group
                    if countryMap[nx][ny] == 1 && island[nx][ny] == 0 {
                        q.enqueue(item: Point(x: nx, y: ny))
                        island[nx][ny] = id
                    }
                }
            }
        }
    }

    // func bfs2(from: Point, to: Point, n: Int) {
    //     var distance = [[Int]](repeating: [Int](repeating: -1, count: 10), count: 10)
    //     let q = Queue<Point>()
    //     q.enqueue(item: from)
    //     distance[from.y][from.x] = 0

    //     while !q.isEmpty() {
    //         let point = q.dequeue()!
    //         let x = point.x
    //         let y = point.y
            
    //         for i in 0..<4 {
    //             let nx = x + dx[i]
    //             let ny = y + dy[i]
    //             if nx >= 0 && nx < n && ny >= 0 && ny < n {
    //                 if  ny == to.y && nx == to.x  {
    //                     bridgeDistance.append(distance[y][x])
    //                     return
    //                 }

    //                 if countryMap[ny][nx] == 0 && distance[ny][nx] == -1 {
    //                     q.enqueue(item: Point(x: nx, y: ny))
    //                     distance[ny][nx] = distance[y][x] + 1
    //                 }
    //             }
    //         }
    //     }
    // }

    func bfs3(x:Int, y:Int, n: Int) {
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: 10), count: 10)
        var distance = [[Int]](repeating: [Int](repeating: -1, count: 10), count: 10)

        let islandId = island[y][x]

        let q = Queue<Point>()
        q.enqueue(item: Point(x:x, y:y))
        visited[y][x] = true
        distance[y][x] = 0

        while !q.isEmpty() {
            let point = q.dequeue()!
            let x = point.x
            let y = point.y
            
            for i in 0..<4 {
                let nx = x + dx[i]
                let ny = y + dy[i]
                if nx >= 0 && nx < n && ny >= 0 && ny < n {
                    if countryMap[ny][nx] == 1 && (island[ny][nx] == islandId) {
                        continue
                    }

                    if countryMap[ny][nx] == 1 && (island[ny][nx] != islandId) {
                        minDistance = min(distance[y][x], minDistance)
                        continue
                    }

                    if countryMap[ny][nx] == 0 && !visited[ny][nx] {
                        q.enqueue(item: Point(x: nx, y: ny))
                        distance[ny][nx] = distance[y][x] + 1
                        visited[ny][nx] = true
                    }
                }
            }
        }
    }

    func isEdge(x:Int, y:Int, n:Int) -> Bool {
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            if nx >= 0 && nx < n && ny >= 0 && ny < n {
                if countryMap[y][x] == 1 && countryMap[ny][nx] == 0 {
                    return true
                }
            }
        }
        return false
    }


    // process the input
    let n = Int(readLine()!)! // n: town map size
    for _ in 0..<n {
        let row = readLine()!.split(separator: " ").map { Int(String($0))! }
        countryMap.append(row)
    }

    // color each island -> island[][]
    var id = 0
    for x in 0..<n {
        for y in 0..<n {
            if countryMap[y][x] == 1 && island[y][x] == 0 {
                id += 1
                bfs(x: x, y: y, id: id, n: n)
            }
        }
    }

    for x in 0..<n {
        for y in 0..<n {
            if isEdge(x: x, y: y, n: n) {
                bfs3(x: x, y: y, n: n)
            }
        }
    }

    print(minDistance)
}

bridge()


