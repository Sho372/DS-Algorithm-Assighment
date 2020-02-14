import Foundation

public final class MyIterable<E>: Sequence {
    private var items: [E] 

    init(_ items: [E]) {
        self.items = items
    }

    public func makeIterator() -> MyIterator<E> {
        return Iterator(self.items)
    }
}


public struct MyIterator<E>: IteratorProtocol {

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

let emojis = MyIterable(["🐶", "🐔", "🐵", "🦁", "🐯", "🐭", "🐱", "🐮", "🐷"])
for emoji in emojis {
    print(emoji)
}

