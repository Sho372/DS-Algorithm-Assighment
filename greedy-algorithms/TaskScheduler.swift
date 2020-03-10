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

class Solution {
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {

        var tasks = tasks
        
        let q = Queue<Character>()
        var timer = [Character:Int]()

        func idle(_ timer: inout [Character:Int]) {
                for k in timer.keys {
                    if timer[k] != 0 { 
                        timer[k]! += 1
                    }
                    if timer[k]! == n+1 {
                        timer[k]! = 0
                    }
                }
        }

        func processTask(_ timer: inout [Character:Int], _ task: Character) {
            timer[task]! += 1
            if timer[task]! == n+1 {
                timer[task]! = 0
            }
            for k in timer.keys {
                if k != task {
                    if timer[k] != 0 {
                        timer[k]! += 1
                    }
                    if timer[k]! == n+1 {
                        timer[k]! = 0
                    }
                }
            }
        }

        func existExecutableTask(_ timer: inout [Character:Int]) -> Bool {
            for k in timer.keys {
                if timer[k] == 0 {
                    return true
                }
            }
            return false
        }


        for c in tasks {
            if timer[c] == nil {
                timer[c] = 0
            } 
        }
        // print(timer)
        // print(existExecutableTask(&timer))
        // processTask(&timer, "A")
        // print(timer)
        // processTask(&timer, "A")
        // print(timer)
        // processTask(&timer, "B")
        // print(timer)
        // processTask(&timer, "A")
        // print(timer)


        var cnt = 0
        for i in 0..<tasks.count {
            print(timer)
            print("tasks: \(tasks)")
            // if !existExecutableTask(&timer) {
            //     // idle
            //     cnt += 1
            //     print("idle,")
            // }
            if timer[tasks[i]] == 0 {
                // process
                cnt += 1
                processTask(&timer, tasks[i])
                print(String(tasks[i]) + ",")
            } else {
                q.enqueue(item: tasks[i])
                continue
            }

            while !q.isEmpty() {
                if !existExecutableTask(&timer) {
                    // idle
                    cnt += 1
                    idle(&timer)
                    print("idle,")
                    break
                }

                let first = q.dequeue()
                if timer[first!] == 0 {
                    // process
                    cnt += 1
                    processTask(&timer, first!)
                    print(String(first!) + ",")
                    break
                } else {
                    q.enqueue(item: first!)
                }
            }
        }
        return cnt
    }
}

let s = Solution()
let tasks: [Character]
tasks = ["A","A","A","B","B","B"]
let n = 2
s.leastInterval(tasks, 2)
