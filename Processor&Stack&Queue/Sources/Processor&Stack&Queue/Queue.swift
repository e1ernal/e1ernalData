//
// Created by DMITRY on 18/12/2019.
//

import Foundation

let sizeQeue: Int = 10

public struct Queue<T> {
    fileprivate(set) var array = [T]()

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count
    }

    public mutating func enqueue(_ element: T) {
        if count < sizeQeue {
            array.append(element)
        } else {
            print("Очередь заполнена.")
        }
    }

    public mutating func dequeue() -> T? {
        if isEmpty {
            print("Пусто")
            return nil
        } else {
            return array.removeFirst()
        }
    }
    public func printQueue() {
        for element in array {
            print(element)
        }
    }
    public var front: T? {
        return array.first
    }
}

//extension Queue: Sequence {
//    public func makeIterator() -> Iterator {
//        fatalError("makeIterator() has not been implemented")
//    }
//}