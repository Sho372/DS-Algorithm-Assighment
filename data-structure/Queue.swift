import Foundation

public final class Queue<E>: Sequence {
    private var count: Int
    private var items: [E]
    init() {
        self.count = 0
        self.items = []
    }

    func enqueue(_ item: E) {
        items.append(item)
        self.count += 1
    }

    func dequeue() -> E? {
        let e = items.remove(at:0)
        self.count -= 1
        return e
    }

    func peek() -> E? {
        return items[0]
    }

    func isEmpty() -> Bool {
        return self.count == 0
    }

    public func makeIterator() -> QueueIterator<E> {
        return QueueIterator(self.items)
    }
}

public struct QueueIterator<E>: IteratorProtocol {

    private let items: [E]
    private var index: Int?

    init(_ items: [E]) {
        self.items = items
    }

    private func nextIndex(for index: Int?) -> Int? {
        if let index = index, index < self.items.count - 1 {
            return index + 1
        }
        if index == nil, !self.items.isEmpty {
            return 0
        }
        return nil
    }

    mutating public func next() -> E? {
        if let index = self.nextIndex(for: self.index) {
            self.index = index
            return self.items[index]
        }
        return nil
    }
}


var nums = Queue<Int>()
print(nums.isEmpty())
nums.enqueue(1)
nums.enqueue(2)
nums.enqueue(3)
print(nums.isEmpty())
for num in nums {
    print(num)
}
