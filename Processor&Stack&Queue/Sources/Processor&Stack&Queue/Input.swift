//
// Created by DMITRY on 19/12/2019.
//

import Foundation

func inputUser(i: Int) -> Task {
    let taskTemp = Task()
    taskTemp.name = i
    print("Введите приоритет: ")
    taskTemp.priority = inputInt() % 3 + 1

    print("Введите время работы")
    taskTemp.durationtime = inputInt() % 10 + 1
    taskTemp.tasktime = taskTemp.durationtime
    return taskTemp
}

func inputInt () -> Int {
    var isWorking: Bool = true
    var answer: Int = 0
    while (isWorking) {
        let tempLine = readLine()
        if let notNilLine = tempLine {
            if let intLine = Int(notNilLine) {
                if intLine > 0 {
                    answer = intLine
                    isWorking = false
                }
            }
        }
        if isWorking == true {
            print("Неправильный ввод. Try again")
        }
    }
    return answer
}



func inputChoice() -> Int{
    var choiceTemp: Int = 0
    var isWorking: Bool = true
    while(isWorking) {
        choiceTemp = inputInt()
        switch choiceTemp {
        case 1, 2:
            isWorking = false
            return choiceTemp
        default:
            print("Неправильный ввод. Try again")
        }
    }
}
