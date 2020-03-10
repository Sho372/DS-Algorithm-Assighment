// collabolate with Doglas

class Solution {
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        var taskPool = tasks
        var i = 0
        var currentTasks = [String]()
        var usedIndexs = [Int]()
        var steps = 0
        while (usedIndexs.count != taskPool.count) {
            if (i > taskPool.count - 1) {
                if (n + 1 > currentTasks.count) {
                    steps += 1
                    currentTasks.append("idle")
                    continue
                }else {
                    currentTasks.remove(at: 0)
                    i = 0
                }
            }
            if (!currentTasks.contains(String(taskPool[i]))) {
                steps += 1
                currentTasks.append(String(taskPool[i]))
                usedIndexs.append(i)
            }
            i += 1
        }
        return steps
    }
}