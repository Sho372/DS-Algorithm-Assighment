func quickSort<T: Comparable>(_ collection: [T], _ low: Int, _ high: Int) -> [T] {

    var sorted = collection

    if(low < high) {
        let partitionIndex = partition(&sorted, low, high);
        print(partitionIndex)
        sorted = quickSort(sorted, low, partitionIndex-1); 
        sorted = quickSort(sorted, partitionIndex+1, high);
    }
    return sorted
}

func partition<T: Comparable>(_ collection: inout [T], _ low: Int, _ high: Int) -> Int {

    let pivot = collection[high]
    var i = low - 1

    for j in low..<high {
        if(collection[j] <= pivot){
            i += 1
            collection.swapAt(i, j)
        }
    }
    collection.swapAt(i+1, high)
    return i+1
}

var array = [10, 80, 30, 90, 40, 50, 70]
print(quickSort(array, 0, 6))



