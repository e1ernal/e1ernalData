
//MARK: Data initialize
var tact: Int = 1
var currentTaskIndex: Int = 0
var countTask: Int = 0 //Всего задач
var countWork: Int = 0 //Количество выполненных задач

var tasksData = [Task]() //All tasks
var queue1 = Queue<Task>()
var queue2 = Queue<Task>()
var queue3 = Queue<Task>()
var stack  = Stack<Task>()

print("Введите количество задач:")
countTask = inputInt()
for i in 1...countTask {
    print("Задача № \(i).")
    printChoice()
    var choice: Int = inputChoice()
    switch choice {
        case 1: //Сгенерировать автоматически
            tasksData.append(generate(i: i))
        case 2: //Вввод вручную
            tasksData.append(inputUser(i: i))
        default:
            print("Something got wrong.")
    }
}
printTasks()
processor() //Start running processor