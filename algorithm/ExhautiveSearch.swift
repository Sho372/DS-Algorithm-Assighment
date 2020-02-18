
func printBinary(_ n: Int, _ prefix: String) {
    // base case -> terminate conditon
    // we have no more digits left to choose
    if n == 0 {
        print(prefix)
    } else {
        for i in 0...1 {
            // choose one & search more
            printBinary(n - 1, prefix + "\(i)")
        }
    }
}

printBinary(2, "")


func printBinaryDebuggable(_ n: Int, _ prefix: String, _ indent: String) {

    // debug
    print("\(indent)\(#function)n=\(n), prefix=\(prefix)")

    // base case -> terminate conditon
    // we have no more digits left to choose
    if n == 0 {
        print(prefix)
    } else {
        for i in 0...1 {
            // choose one & search more
            printBinaryDebuggable(n - 1, prefix + "\(i)", indent + "    ")
        }
    }
}

printBinaryDebuggable(2, "", "")


func rollDiceHelper(dice: Int, _ chosen: inout [Int]) {
    if dice == 0 {
        print(chosen)
    } else {
        for i in 1...6 {
            chosen.append(i)
            rollDiceHelper(dice: dice-1, &chosen)
            chosen.removeLast()
        }
    }
}

func rollDice(dice: Int) {
    var chosen = [Int]() 
    // pass by reference (same array)
    rollDiceHelper(dice: dice, &chosen)
}

rollDice(dice: 2)
