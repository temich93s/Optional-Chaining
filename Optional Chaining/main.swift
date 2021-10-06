//
//  main.swift
//  Optional Chaining
//
//  Created by 2lup on 07.10.2021.
//

import Foundation

print("Hello, World!")

//MARK: ОП как альтернатива принудительному извлечению
print("\n//ОП как альтернатива принудительному извлечению")

class Person {
    var residence: Residence?
}
 
class Residence {
    var numberOfRooms = 1
}

let john = Person()

//let roomCount = john.residence!.numberOfRooms
// ошибка runtime

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Выведет "Unable to retrieve the number of rooms."

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Выведет "John's residence has 1 room(s)."



