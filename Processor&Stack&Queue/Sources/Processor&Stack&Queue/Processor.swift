//
// Created by DMITRY on 19/12/2019.
//

import Foundation


func isRunning () -> Bool{
    var flagTemp: Bool = true
    if countWork > tasksData.count {
        print("All tasks are completed.")
        print("STOPPED.")
        flagTemp = false //Stop
    } else {
        flagTemp = true //Work
    }
    return flagTemp
}

var currentWork = (Task(), false) // (0, 1) //Текущая задача на процессоре

func processor () {


    while isRunning() {
        
        printAll(tactT: tact)
        var currentTask = Task()
       
        if currentTaskIndex < tasksData.count {
            currentTask = tasksData[currentTaskIndex] //Поступившая задача
            printEnteringTask(currentT: currentTask)
        }
        else {
            var maxTask = Task() //Наибольший приоритет
            var indexStorage: Int = 0
            if !queue1.isEmpty {
                if queue1.front!.priority > maxTask.priority {
                    maxTask = queue1.front!
                    indexStorage = 1
                }
            }
            if !queue2.isEmpty {
                if queue2.front!.priority > maxTask.priority {
                    maxTask = queue2.front!
                    indexStorage = 2
                }
            }
            if !queue3.isEmpty {
                if queue3.front!.priority > maxTask.priority {
                    maxTask = queue3.front!
                    indexStorage = 3
                }
            }
            if !stack.isEmpty {
                if stack.top!.priority > maxTask.priority {
                    maxTask = stack.top!
                    indexStorage = 4
                }
            }
            switch indexStorage {
                case 1:
                    queue1.dequeue()
                case 2:
                    queue2.dequeue()
                case 3:
                    queue3.dequeue()
                case 4:
                    stack.pop()
                default:
                    print("Queues and stack are empty.")
            }
            if currentWork.1 == false {
                currentWork.0 = maxTask
            } else {
            if currentWork.1 == true {
                if currentWork.0.priority < maxTask.priority {
                    stack.push(currentWork.0)
                    currentWork.0 = maxTask
                }
            }
            
            }
            currentTask = maxTask
        }

            if currentWork.0.tasktime == 0 { //Задача выполнена
                countWork += 1 //Увеличилось кол-во выполненных задач
                currentWork.1 = false
            }

            if currentWork.1 == false { //Если процессор свободен
                currentWork.0 = currentTask
                currentWork.1 = true
            } else if currentWork.1 == true { //Если процессор занят
                if currentWork.0.priority < currentTask.priority { //Если приоритет поступившей задачи выше, чем на процессоре
                    stack.push(currentWork.0)
                    currentWork.0 = currentTask
                } else { //Если приоритет поступившей задачи ниже, чем на процессоре
                    switch currentTask.priority {
                    case 1:
                        queue1.enqueue(currentTask)
                    case 2:
                        queue1.enqueue(currentTask)
                    case 3:
                        queue1.enqueue(currentTask)
                    default:
                        print("Something got wrong.")
                    }
                }
            }
        
        currentWork.0.tasktime -= 1
        tact += 1
        currentTaskIndex += 1
    }
}
