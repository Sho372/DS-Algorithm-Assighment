class Solution {
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {

        var tasks = tasks
        var timer = [Character:Int]()

        var array = [[Int]](repeating: [Int](repeating: 0, count: 2), count: 26)
        for c in tasks {
            let index = Int(c.asciiValue!) - 65
            array[index][0] = index
            array[index][1] += 1
        }

        var order = array.sorted {$0[1] > $1[1]}

        for c in tasks {
            if timer[c] == nil {
                timer[c] = 0
            } 
        }

        func idle(_ timer: inout [Character:Int]) {
                for k in timer.keys {
                    if timer[k] != 0 { 
                        timer[k]! += 1
                    }
                    if timer[k]! == n+1 {
                        timer[k]! = 0
                    }
                }
        }

        func processTask(_ timer: inout [Character:Int], _ task: Character) {
            timer[task]! += 1
            if timer[task]! == n+1 {
                timer[task]! = 0
            }
            for k in timer.keys {
                if k != task {
                    if timer[k] != 0 {
                        timer[k]! += 1
                    }
                    if timer[k]! == n+1 {
                        timer[k]! = 0
                    }
                }
            }
        }

        func existExecutableTask(_ timer: inout [Character:Int], _ tasks: inout [Character]) -> Bool {
            for k in tasks {
                if timer[k] == 0 {
                    return true
                }
            }
            return false
        }

        var cnt = 0

        // print("order: \(order)")

        while !tasks.isEmpty {
            if !existExecutableTask(&timer, &tasks) {
                idle(&timer)
                cnt += 1
                // print("idle")
                continue
            }
            for i in 0..<order.count {
                let cc = Character(UnicodeScalar(order[i][0] + 65)!)
                if timer[cc] == 0 && order[i][1] != 0 {
                    // print(cc)
                    order[i][1] -= 1
                    order = order.sorted {$0[1] > $1[1]}
                    let firstIndex = tasks.firstIndex(of: cc)!
                    tasks.remove(at: firstIndex)
                    cnt += 1
                    processTask(&timer, cc)
                    break
                }
            }
        }
        return cnt
    }
}
