class Solution {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        //スタート地点を一個づつずらす
        for i in 0..<gas.count {
            var sum = 0
            //スタート地点からガスステーションを回っていく 
            for j in i..<i+gas.count {
                let a = j % gas.count
                //sumにガスを足す
                sum += gas[a]
                //もし、現在のsumが次のcostより小さかったらその時点でbreak -> このスタート地点は無視
                if sum < cost[a] {
                    break
                } else {
                //もし、現在のsumが次のcostより大きかったら次のガスステーションに移る
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


let s = Solution()
let gas1 = [1,2,3,4,5]
let cost1 = [3,4,5,1,2]
print(s.canCompleteCircuit(gas1, cost1))

let gas2 = [2,3,4]
let cost2 = [3,4,3]
print(s.canCompleteCircuit(gas2, cost2))
