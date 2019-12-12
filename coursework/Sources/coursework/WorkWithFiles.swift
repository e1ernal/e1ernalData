//
// Created by DMITRY on 10/12/2019.
//

import Foundation

func fileInput() throws {
    // File path
    let path = "/Users/goodnightlemon/Documents/SUAI/Курсач/coursework/Sources/coursework/input.txt"

    do {
        // Read an entire text file into an String.
        let contents = try String(contentsOfFile: path,
                encoding: String.Encoding(rawValue: String.Encoding.ascii.rawValue))
        if (contents == nil) {
            print("File is empty or not found.")
        }
        // Works with all lines.
        var workerTemp = Worker()
        var countOfLines: Int = 0
        contents.enumerateLines(invoking:{ (line, stop) -> () in
            switch countOfLines % 3 {
            case 0:
                workerTemp.name = line
            case 1:
                workerTemp.position = line
            case 2:
                workerTemp.yearOfEmployment = Int(line)
                list.add(workerTemp)
                workerTemp = Worker()
            default:
                printError()
            }
            countOfLines += 1
        })


    }

}

func fileOutput (data: LinkedList<Worker>) {

    // Target path.
    let path = "/Users/goodnightlemon/Documents/SUAI/Курсач/coursework/Sources/coursework/output.txt"

    // Write the text to the path.
    var text = ""
    for element in data {
        let worker = element as Worker
        text += doStringWorkerToFile(workerTemp: worker)
    }
    do {
        try text.write(
                toFile: path,
                atomically: false,
                encoding: String.Encoding.utf8
        )
    } catch {
    }

}