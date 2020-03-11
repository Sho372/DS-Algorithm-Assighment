class Solution {
    func twoCitySchedCost(_ costs: [[Int]]) -> Int {

        var costs = costs

        for i in 0..<costs.count {
            costs[i].append(abs(costs[i][0] - costs[i][1]))
        }
        print(costs)
        let order = costs.sorted {$0[2] > $1[2]}
        print(order)

        var minCost = 0
        var numA = costs.count / 2
        var numB = costs.count / 2
        for i in 0..<order.count {

            if numA <= 0 {
                minCost += order[i][1]
                continue
            }

            if numB <= 0 {
                minCost += order[i][0]
                continue
            }

            if order[i][0] <= order[i][1] {
                minCost += order[i][0]
                numA -= 1 
            } else {
                minCost += order[i][1]
                numB -= 1
            }
        }
        return minCost
    }
}

