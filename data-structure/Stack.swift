import Foundation

public final class Stack<E>: Sequence {
    private var count: Int
    private var items: [E]
    init() {
        self.count = 0
        self.items = []
    }

    func push(_ item: E) {
        items.append(item)
        self.count += 1
    }

    func pop() -> E? {
        let e = items.removeLast()
        self.count -= 1
        return e
    }

    func peek() -> E? {
        return items[self.count-1]
    }

    func isEmpty() -> Bool {
        return self.count == 0
    }

    public func makeIterator() -> StackIterator<E> {
        return StackIterator(self.items)
    }
}

public struct StackIterator<E>: IteratorProtocol {

    private let items: [E]
    private var index: Int?

    init(_ items: [E]) {
        self.items = items
        self.index = self.items.count
    }

    private func nextIndex(for index: Int?) -> Int? {
        if let index = index, 0 < index {
            return index - 1
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


var nums = Stack<Int>()
print(nums.isEmpty())
nums.push(1)
nums.push(2)
nums.push(3)

for num in nums {
    print(num)
}
