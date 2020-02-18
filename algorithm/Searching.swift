import Foundation

// DocString: option + command + /

/// Linear Search Algorithm
///   Parameters
///    collection on array of intergers
///    target search target

func linearSearch(_ collection:[Int], _ target:Int) -> Int {
    for i in 0..<collection.count {
        if collection[i] == target {
            return i
        }
    }
    return -1
}

// O(lg N)
func binarySearch(_ collection:[Int], _ target: Int) -> Int? {

    var min = 0
    var max = collection.count - 1

    // for _ in 0...collection.count{
    while(min <= max) {
        // for _ in min..<max {
        let mid = (min + max) / 2

        if(collection[mid] == target) {
            return mid
        }

        if(collection[mid] < target) {
            // min = mid
            min = mid + 1
        } else {
            // max = mid
            max = mid - 1
        }
        // }
    }
    return nil
}

let collection:[Int] = [1,3,6,7,9,10,12,18]
print(binarySearch(collection, 1))  // 0
print(binarySearch(collection, 9))  // 4
print(binarySearch(collection, 18)) // 7

let collection2:[Int] = [1,3,6,7,9,10,12]
print(binarySearch(collection2, 1) )  // 0
print(binarySearch(collection2, 9) )  // 4
print(binarySearch(collection2, 18)) // -1


if let i = binarySearch(collection2, 18) {
    print(i)
}

