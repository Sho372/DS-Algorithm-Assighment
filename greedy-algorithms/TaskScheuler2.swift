class Solution {
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {

        var tasks = tasks
        // tasks.sort()
        var timer = [Character:Int]()

        for c in tasks {
            if timer[c] == nil {
                timer[c] = 0
            } 
        }
        print(timer)

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
        while !tasks.isEmpty {
            // print("tasks: \(tasks)")
            // print("timer: \(timer)")
            if !existExecutableTask(&timer, &tasks) {
                idle(&timer)
                cnt += 1
                print("idle")
                continue
            }
            for i in 0..<tasks.count {
                if timer[tasks[i]] == 0 {
                    let c = tasks[i]
                    print(c)
                    tasks.remove(at: i)
                    cnt += 1
                    processTask(&timer, c)
                    break
                }
            }
            // print("cnt: \(cnt)")
        }
        return cnt
    }
}

let s = Solution()
var tasks: [Character]
// tasks = ["B","F","J","J","H","A","D","C","C","D","J","E","B","E","C","H","E","E","G","E","H","I","I","E","H","F","C","G","H","F","E","E","I","D","D","A","E","A","C","E","F","J","E","F","G","J","A","A","A","B","E","J","H","C","A","E","D","A","E","I","H","B","A","C","E","F","J","D","F","I","I","H","J","E","B","H","H","A","J","C","C","D","C","B","C","H","H","I","H","D","C","B","D","C","H","A","F","A","J","D","F","E","H","I","D","A","E","B","H","J","F","D","C","J","J","I","A","I","J","H","A","I","I","G","C","C","H","D","B","B","B","H","I","D","B","C","H","I","I","G","E","D","D","A","E","D","H","C","J","H","C","E","I","F","A","I","E","G","A","E","F","I","B","J","B","J","B","G","A","D","C","B","I","A","C","J","J","J","B","E","E","E","B","E","B","H","B","J","H","F","G","B","B","I","C","D","I","D","D","A","I","D","H","A","J","D","J","D","I","G","F","F","B","G","A","F","I","I","H","C","B","H","H","E","F","A","H","G","F","D","G","F","A","C","F","D","F","C","J","A","D","H","G","D","D","G","C","G","C","I","B","G","E","J","C","G","J","G","E","F","F","I","D","D","E","G","F","A","F","H","D","C","B","E","H","G","H","B","A","D","A","J","A","C","B","G","C","A","J","E","I","G","H","J","A","J","I","D","I","G","B","G","I","A","B","J","B","H","E","G","G","I","G","G","C","J","J","J","H","G","A","G","B","G","I","G","A","D","B","A","E","I","H","E","G","H","J","F","H","I","A","E","A","I","A","D","D","B","D","G","E","C","J","C","C","B","F","F","B","E","A","G","D","I","G","D","J","D","G","I","B","J","J","B","F","D","I","C","I","B","J","B","D","D","A","D","C","G","A","G","C","G","C","E","C","G","A","J","C","E","F","C","C","E","J","D","H","H","F","E","D","G","E","E","I","B","G","A","C","C","E","J","F","H","C","A","G","H","G","A","G","A","D","B","E","F","H","C","C","B","I","F","H","I","C","H","G","G","C","E","A","J","F","F","F","B","D","I","E","I","F","E","F","G","G","A","D","I","A","J","A","H","J","I","H","H","A","B","B","B","I","C","J","C","G","J","G","E","I","H","D","E","H","J","A","G","A","G","A","C","F","C","G","E","G","J","D","H","H","B","J","F","J","J","B","J","D","D","G","B","I","I","H","G","B","I","E","D","H","H","I","B","A","A","A","D","H","J","H","D","J","E","D","G","J","B","B","F","G","J","G","E","G","E","E","F","H","F","J","A","G","I","D","C","H","A","C","F","B","J","E","I","A","G","J","D","I","F","I","J","H","E","D","J","A","E","G","B","B","J","I","J","H","F","D","F","F","A","G","F","F","I","C","H","E","E","G","A","D","F","I","D","D","C","B","G","C","D","G","H","F","D","J","D","B","A","J","J","I","H","F","G","D","J","H","I","H","I","A","A","I","C","B","H","G","I","C","F","E","J","J","F","F","D","F","A","J","H","B","G","A","F","D","G","D","C","F","J","F","G","D","H","J","C","A","E","C","G","J","G","I","C","G","H","G","J","D","D","G","D","F","F","J","B","D","C","E","F","G","D","A","J","H","D","F","C","B","H","C","I","D","C","F","E","C","D","J","D","E","G","C","D","H","J","E","H","I","I","A","C","E","C","I","B","A","B","E","E","H","E","B","H","C","G","B","C","C","D","G","G","A","F","A","B","D","G","F","A","H","G","C","E","D","B","H","D","F","F","G","A","J","H","E","B","C","B","B","B","H","D","F","B","B","C","G","A","C","E","J","H","F","F","D","G","J","D","F","J","G","H","B","D","B","D","D","G","J","H","B","D","F","E","E","G","D","H","B","A","I","E","B","E","B","D","I","C","A","A","E","J","A","B","A","F","C","J","F","F","F","A","I","J","F","H","G","C","F","E","D","C","B","C","G","G","G","A","B","J","J","F","J","G","C","D","B","C","F","H","I","F","D","C","I","J","D","I","G","B","G","I","J","E","H","G","G","J","J","A","E","E","I","G","E","H","F","F","C","A","J","I","I","D","C","E","G","A","A","H","F","A","I","B","H","J","H","B","H","A","A","A","G","I","I","D","F","F","C","H","D","B","J","F","G","E","F","J","A","I","G","J","J","F","F","G","B","B","D","F","E","G","D","D","A","D","D","G","C","C","I","C","H","I","C","E","G","C","E","J","F","G","J","B","I","B","B","C","B","G","A","J","H","C","G","D","E","H","E","H","A","H","I","A","J","C","G","B","G","H","G","H"]
// tasks = ["F","J","J","A","J","F","C","H","J","B","E","G","G","F","A","C","I","F","J","C","J","C","H","C","A","D","G","H","B","F","G","C","C","A","E","B","H","J","E","I","F","D","E","A","C","D","B","D","J","J","C","F","D","D","J","H","A","E","C","D","J","D","G","G","B","C","E","G","H","I","D","H","F","E","I","B","D","E","I","E","C","J","G","I","D","E","D","J","C","A","C","C","D","I","J","B","D","H","H","J","G","B","G","A","H","E","H","E","D","E","J","E","J","C","F","C","J","G","B","C","I","I","H","F","A","D","G","F","C","C","F","G","C","J","B","B","I","C","J","J","E","G","H","C","I","G","J","I","G","G","J","G","G","E","G","B","I","J","B","H","D","H","G","F","C","H","C","D","A","G","B","H","H","B","J","C","A","F","J","G","F","E","B","F","E","B","B","A","E","F","E","H","I","I","C","G","J","D","H","E","F","G","G","D","E","B","F","J","J","J","D","H","E","B","D","J","I","F","C","I","E","H","F","E","G","D","E","C","F","E","D","E","A","I","E","A","D","H","G","C","I","E","G","A","H","I","G","G","A","G","F","H","J","D","F","A","G","H","B","J","A","H","B","H","C","G","F","A","C","C","B","I","G","G","B","C","J","J","I","E","G","D","I","J","I","C","G","A","J","G","F","J","F","C","F","G","J","I","E","B","G","F","A","D","A","I","A","E","H","F","D","D","C","B","J","I","J","H","I","C","D","A","G","F","I","B","E","D","C","J","G","I","H","E","C","E","I","I","B","B","H","J","C","F","I","D","B","F","H","F","A","C","A","A","B","D","C","A","G","B","G","F","E","G","A","A","A","C","J","H","H","G","C","C","B","C","E","B","E","F","I","E","E","D","I","H","G","F","A","H","B","J","B","G","H","C","C","B","G","C","B","A","E","G","A","J","G","D","C","I","G","F","G","G","A","J","E","I","D","E","A","F","A","H","C","E","D","D","D","H","I","F","F","A","F","A","A","C","J","D","J","H","I","F","A","C","B","C","A","C","C","H","A","J","I","B","A","I","F","J","C","I","B","C","E","E","E","J","G","F","E","I","A","A","E","B","J","H","H","H","A","H","J","E","F","E","F","G","J","D","I","D","I","F","B","J","D","A","A","D","F","G","B","J","H","F","A","D","H","C","B","A","J","H","I","F","H","E","G","B","A","F","F","A","C","D","G","I","I","J","H","H","C","J","G","B","A","D","B","F","J","D","I","A","F","F","F","F","A","E","B","C","G","H","E","B","B","A","G","D","C","C","E","A","C","F","G","A","I","F","B","H","J","G","C","B","H","D","A","H","B","H","H","C","A","F","I","C","F","A","C","J","I","H","H","F","B","B","D","E","C","J","F","C","E","A","J","E","C","A","E","B","A","J","F","J","J","J","H","H","C","I","E","G","G","H","J","J","H","H","H","J","H","A","G","I","C","E","C","D","G","G","F","H","D","G","H","A","E","I","D","A","H","G","E","A","B","F","I","C","A","F","B","A","I","F","G","I","F","D","A","B","J","B","D","F","G","J","J","A","A","C","H","G","F","B","I","I","J","A","H","D","F","E","F","J","B","F","C","G","E","A","G","H","E","H","H","F","I","G","C","C","G","J","B","H","F","H","D","I","B","D","I","F","H","I","D","F","G","G","E","A","C","A","G","H","G","H","J","F","D","F","G","D","D","C","J","C","J","G","G","G","G","H","H","G","D","E","H","G","C","B","F","I","F","C","H","J","I","A","F","D","C","F","C","E","E","D","D","C","G","B","F","E","J","C","I","E","D","B","B","I","I","I","H","C","E","C","J","F","G","A","I","J","D","I","C","G","F","I","E","I","E","F","A","G","E","J","A","I","A","D","A","G","J","F","E","D","I","A","E","J","I","C","J","B","F","B","E","C","E","F","G","E","J","J","I","E","D","F","C","H","H","B","G","D","I","I","F","B","G","C","F","J","B","G","J","H","D","G","C","C","I","I","E","I","B","H","B","I","G","F","H","G","C","J","D","C","E","G","F","C","H","D","A","C","D","H","B","C","H","I","B","A","J","C","B","D","J","D","H","F","B","A","G","G","J","I","E","F","A","D","H","D","B","C","A","H","F","G","B","F","H","B","H","I","J","D","H","I","B","C","D","G","A","E","A","A","I","F","I","F","B","B","I","F","A","E","I","A","B","G","C","F","I","A","F","I","D","H","B","I","I","B","J","F","E","B","B","B","D","C","J","E","J","J","G","D","F","F","F","G","I","H","J","J","G","D","G","F"]
tasks = ["A","A","A","A","A","B","C","D"]  // 21
// tasks = ["B","A","A","A","A","A","C","D"]   // 22
// tasks = ["D","C","B","A","A","A","A","A"] // 24

// tasks.sort(by: >)
// print(tasks)

let n = 4
print(s.leastInterval(tasks, n))

