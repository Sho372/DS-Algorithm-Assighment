class Solution {
    func partitionLabels(_ S: String) -> [Int] {
        var partitions = [Int]()
        let characters = Array(S)
        var maxIndex = -1
        for i in 0..<characters.count {
            maxIndex = max(characters.lastIndex(of: characters[i])!,maxIndex)
            if i == maxIndex {
                partitions.append(maxIndex)
            }
        }
        var sizes = [Int]()
        sizes.append(partitions[0]+1)
        for i in 1..<partitions.count {
            sizes.append(partitions[i]-partitions[i-1])
        }
        return sizes
    }
}
