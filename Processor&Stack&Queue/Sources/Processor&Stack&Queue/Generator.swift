//
// Created by DMITRY on 18/12/2019.
//

import Foundation

func generate(i: Int) -> Task {
    var taskTemp = Task()
    taskTemp.name = i
    taskTemp.priority = Int.random(in: 1..<100) % 3 + 1
    taskTemp.durationtime = Int.random(in: 1..<100) % 10 + 1
    taskTemp.tasktime = taskTemp.durationtime
    return taskTemp
}
