//
// Created by DMITRY on 19/12/2019.
//

import Foundation

func printChoice() {
    print("""
          __________________________________
                       ВЫБОР:
            1 - Сгенерировать автоматически
            2 - Вввод вручную
          __________________________________
          """)
    print("Введите (1/2):")
}

func printTask(task: Task, i: Int) {
    print ("ЗАДАЧА: \(i).")
    print ("   Приоритет: \(task.priority)")
    print ("   Осталось: \(task.tasktime)")
    print ("   Время: \(task.durationtime)")
}

func printQueue(storageName: String, storage: Queue<Task>) {
    print("\(storageName):")
    if storage.count == 0 {
        print("   Empty")
    } else {
        for element in storage.array {
            printTask(task: element, i: element.name)
        }
    }
}

func printStack(storageName: String, storage: Stack<Task>) {
    print("\(storageName):")
    if storage.count == 0 {
        print("   Empty")
    } else {
        for element in storage.array {
            printTask(task: element, i: element.name)
        }
    }
}

func printAll(tactT: Int) {
    print("______")
    print("ТАКТ: \(tactT).")
    print("______")
    printQueue(storageName: "Queue1", storage: queue1)
    printQueue(storageName: "Queue2", storage: queue2)
    printQueue(storageName: "Queue3", storage: queue3)
    printStack(storageName: "Stack", storage: stack)
    print("Processor:")
    if currentWork.1 == true {
        printTask(task: currentWork.0, i: currentWork.0.name)
    } else {
        print("   Empty")
    }
}

func printEnteringTask(currentT: Task) {
    print("Входная задача:")
    printTask(task: currentT, i: currentT.name)
}

func printTasks() {
    print("All tasks:")
    for element in tasksData {
        printTask(task: element, i: element.name)
    }
}
