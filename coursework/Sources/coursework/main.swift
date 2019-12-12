//
//  InputMenu.swift
//  Workers
//
//  Created by DMITRY on 07/12/2019.
//  Copyright © 2019 Dmitry Smirnykh. All rights reserved.
//

import Foundation

var list = LinkedList<Worker>()

func doStringWorker(workerTemp: Worker) -> String{
    var result: String = ""
    result += (workerTemp.name != nil) ? workerTemp.name! : "-"
    result += "\n"
    result += (workerTemp.position != nil) ? workerTemp.position! : "-"
    result += "\n"
    result += (workerTemp.yearOfEmployment != nil) ? String(workerTemp.yearOfEmployment!) : "-"
    result += "\n"
    return result
}

func doStringWorkerToFile(workerTemp: Worker) -> String{
    var result: String = ""
    result += (workerTemp.name != nil) ? workerTemp.name! : "-"
    result += "\n"
    result += (workerTemp.position != nil) ? workerTemp.position! : "-"
    result += "\n"
    result += (workerTemp.yearOfEmployment != nil) ? String(workerTemp.yearOfEmployment!) : "-"
    result += "\n"
    return result
}

func printList(listTemp: LinkedList<Worker>) {
    var node = listTemp.head
    while (node != nil) {
        print(doStringWorker(workerTemp: node!.value))
        node = node?.next
    }
}

func userInputFromConsole() -> String {
    var userInputFromConsoleWorking: Bool = true
    while (userInputFromConsoleWorking) {
        let userInput: String? = readLine()
        if let userLine = userInput {
            userInputFromConsoleWorking = false
            return userLine
        } else {
            printError()
            printTryAgain()
        }
    }
}

func userInputFromConsoleInt() -> Int {
    var userInputFromConsoleWorking: Bool = true
    while (userInputFromConsoleWorking) {
        let userInput: String? = readLine()
        if let userLine = Int(userInput!) {
            if userLine <= currentYear {
                userInputFromConsoleWorking = false
                return userLine
            } else {
                printError()
                printTryAgain()
            }
        } else {
            printError()
            printTryAgain()
        }
    }
}


func inputTempWorker() -> Worker {
    let workerTemp = Worker.init()
    print("Name: ")
    workerTemp.name = userInputFromConsole()
    print("Position: ")
    workerTemp.position = userInputFromConsole()
    print("Year of employment: ")
    workerTemp.yearOfEmployment = userInputFromConsoleInt()
    return workerTemp
}

func userAdd() {
    print("ADD WORKER.")
    let workerTemp = inputTempWorker()
    list.add(workerTemp)
}



func userFind() {
    let foundWorkers = LinkedList<Worker>()
    let userInputYear: Int = userInputFromConsoleInt()
    let yearToFind = currentYear - userInputYear
    var node = list.head
    while node != nil {
        if let safeNodeYear = node?.value.yearOfEmployment {
            if safeNodeYear <= yearToFind {
                foundWorkers.add(node!.value)
            }
        }
        node = node!.next
    }
    if (foundWorkers.count > 0) {
        printList(listTemp: foundWorkers)
        printListCount(list_: foundWorkers)
        var yesNo: Bool = false
        while yesNo == false {
            print("Do you want to save found workers to file? (y/n)")
            let answer = userInputFromConsole()
            switch answer {
                case "y", "Y", "yes", "Yes":
                    fileOutput(data: foundWorkers)
                    print("Data saved to file.")
                    yesNo = true
                case "n", "N", "no", "No":
                    print("Data was not saved.")
                    yesNo = true
                default:
                    printError()
                    printTryAgain()
            }
        }
    } else {
        print("No workers found.")
    }
}

func userShow(listTemp: LinkedList<Worker>) {
    guard (listTemp.count != 0) else { return print("List is empty.") }
    printList(listTemp: listTemp)
}

func quicksortWorker(_ a: LinkedList<Worker>) -> LinkedList<Worker>{
    guard a.count > 1 else { return a }

    let pivot = a[a.count/2].yearOfEmployment
    let less = a.filter { $0.yearOfEmployment! < pivot! }
    let equal = a.filter { $0.yearOfEmployment! == pivot! }
    let greater = a.filter { $0.yearOfEmployment! > pivot! }
    let result = quicksortWorker(less)
    result.add(equal)
    result.add(quicksortWorker(greater))
    return result
}

func findWorkerIndex(worker: Worker) -> Int? {
    for i in 0...list.count-1 {
        if list[i].name == worker.name &&
           list[i].position == worker.position &&
           list[i].yearOfEmployment == worker.yearOfEmployment {
            return i
        }
    }
    return nil
}

var commands: String?
var programIsWorking = true

func work() {
    while programIsWorking {
        commands = readLine()
        switch commands {
            case "add":
                userAdd()
                printListCount(list_: list)
            case "find":
                print("Write minimal experience: ")
                userFind()
                printDone()
            case "findW":
                print("FIND WORKER.")
                let workerTemp = inputTempWorker()

                var indexOfWorker: Int? = findWorkerIndex(worker: workerTemp)
                print("index = ", indexOfWorker)
                guard (indexOfWorker != nil) else { printError()
                    continue }

                print("Delete or edit? (d/e)")
                var currentanswer = userInputFromConsole()
                switch currentanswer {
                    case "d", "D": // Delete element
                        list.remove(at: indexOfWorker!)
                        print("Worker was deleted.")
                        printListCount(list_: list)
                    case "e", "E": //Edit element
                        print("REWRITE WORKER.")
                        print("Name: ")
                        list[indexOfWorker!].name = userInputFromConsole()
                        print("Position: ")
                        list[indexOfWorker!].position = userInputFromConsole()
                        print("Year of employment: ")
                        list[indexOfWorker!].yearOfEmployment = userInputFromConsoleInt()
                        print("Worker was edited.")
                        printDone()
                    default:
                        printError()
                }
            case "show":
                userShow(listTemp: list)
                printListCount(list_: list)
            case "sort":
                list = quicksortWorker(list)
                printList(listTemp: list)
            case "help":
                printCommands()
            case "exit":
                print("CLOSED.")
                programIsWorking = false
            default:
                printError()
        }
    }

}

do {
    try fileInput()

} catch {}
printStart()
work()
