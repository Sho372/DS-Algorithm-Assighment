import Foundation

func myBubbleSort<T: Comparable>(_ collection: [T]) -> [T] {

    var mutableCollection = collection
    let size = mutableCollection.count 

    for i in 0..<size {
        for j in 0..<size - i - 1 {
            if(mutableCollection[j] > mutableCollection[j+1]) {
                let tmp = mutableCollection[j]
                mutableCollection[j] = mutableCollection[j+1]
                mutableCollection[j+1] = tmp
            }
        }
    }
    return mutableCollection
}


func f(_ collection:[Int]) {
    for (index, element) in collection.enumerated() {
        print("index: \(index), element: \(element)")
    }
}


var collection = [3,5,1,4,6]
// print(myBubbleSort(collection))

/* divide-and-conquer method
        -> marge sort
        -> quick sort
*/

func divideAndConquer1<T: Comparable>(_ array: [T]) -> [T] {

    // base case
    // if (array.count == 1 ) {
    //     return array
    // }

    guard array.count > 1 else {
        return array
    }

    let mid = array.count / 2

    // recusive case
    // https://developer.apple.com/documentation/swift/arrayslice
    let left = divideAndConquer1(Array(array[0..<mid]))
    let right = divideAndConquer1(Array(array[mid...]))

    // marge
    let marged = left + right
    print("marge: \(marged)")

    return marged //[3, 5, 1, 4, 6] 
}

print(divideAndConquer1((collection)))

func divideAndConquer2<T: Comparable>(_ array: inout [T], _ start: Int, _ end: Int) {
    print("[Call] start:  \(start), end: \(end)")

    if start < end {
        let pivotIndex = end / 2
        print("start:  \(start), end: \(pivotIndex)")
        divideAndConquer2(&array, start, pivotIndex)
        print("start:  \(pivotIndex+1), end: \(end)")
        divideAndConquer2(&array, pivotIndex+1, end)
    }
    print("end")
}

print(collection)
print(divideAndConquer2(&collection, 0, collection.count-1))
print(collection)