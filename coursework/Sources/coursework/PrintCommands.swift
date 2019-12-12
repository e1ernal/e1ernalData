//
// Created by DMITRY on 10/12/2019.
//

import Foundation

func printCommands() {
    print("""
          .___________________________.
          |        Commands:          |
          |add    - Add element,      |
          |find   - Find workers,     |
          |show   - Show all workers, |
          |sort   - Sort list by year,|
          |findW  - Find worker and   |
          |         delete or edit,   |
          |___________________________|
          |help   - Show commands,    |
          |exit   - Stop the program. |
          .___________________________.
          Write the command:
          """)
}

func printError() {
    print("ERROR. Something got wrong.")
}
func printDone() {
    print("Done.")
}

func printTryAgain() {
    print("Try again:")
}

func printStart() {
    print("The program started.")
    print("Data was loaded from file.")
    printCommands()
}

func printListCount(list_ : LinkedList<Worker>) {
    print("Done. Count of elements \(list_.count).")
}