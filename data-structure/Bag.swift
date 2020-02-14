import Foundation

public final class Bag<E>: Sequence {
    private var count: Int
    private var items: [E] 
    init() {
        self.count = 0
        self.items = []
    }

    func add(_ item: E){
        items.append(item)
        self.count += 1
    }

    func isEmpty() -> Bool {
        return self.count == 0
    }

    public func makeIterator() -> BagIterator<E> {
        return BagIterator(self.items)
    }
}

public struct BagIterator<E>: IteratorProtocol {

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

var nums = Bag<Int>()
nums.add(1)
nums.add(2)
nums.add(3)

for num in nums {
    print(num)
}
