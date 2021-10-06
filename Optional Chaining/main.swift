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


//MARK: Определение классовых моделей для ОП
print("\n//Определение классовых моделей для ОП")

class Person1 {
    var residence: Residence?
}

class Residence1 {
    var rooms = [Room1]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room1 {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("Общее количество комнат равно \(numberOfRooms)")
    }
    var address: Address1?
}

class Room1 {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address1 {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}
