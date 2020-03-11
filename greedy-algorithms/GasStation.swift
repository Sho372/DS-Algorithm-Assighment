class Solution {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        for i in 0..<gas.count {
            var sum = 0
            for j in i..<i+gas.count {
                let a = j % gas.count
                sum += gas[a]
                if sum < cost[a] {
                    break
                } else {
                    sum -= cost[a]
                }
                if j == i+gas.count-1 {
                    return i
                }
            }
        }
        return -1
    }
}