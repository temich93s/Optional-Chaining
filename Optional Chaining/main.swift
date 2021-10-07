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
    var residence: Residence1?
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


//MARK: Доступ к свойствам через ОП
print("\n//Доступ к свойствам через ОП")

let john1 = Person1()
if let roomCount = john1.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Выведет "Unable to retrieve the number of rooms."

let someAddress = Address1()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
//john.residence? все еще nil, потому что код справа после присваивания не вычисляется
john1.residence?.address = someAddress
print(john1.residence)

func createAddress() -> Address1 {
    print("Function was called.")
    
    let someAddress = Address1()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
//john.residence? все еще nil, потому что код справа после присваивания не вычисляется, и print не выводится
john1.residence?.address = createAddress()
print(john1.residence)

//это присваивание значения
john1.residence = Residence1()
print(john1.residence)

//это вызов опциональной последовательности, код выполняется так как уже не nil
john1.residence?.address = createAddress()
john1.residence? = Residence1()
john1.residence?.address = createAddress()


//MARK: Вызов методов через ОП
print("\n//Вызов методов через ОП")

john1.residence = nil

if john1.residence?.printNumberOfRooms() != nil {
    print("Есть возможность вывести общее количество комнат.")
} else {
    print("Нет возможности вывести общее количество комнат.")
}
// Выведет "Нет возможности вывести общее количество комнат."

if (john1.residence?.address = someAddress) != nil {
    print("Была возможность установить адрес.")
} else {
    print("Не было возможности установить адрес.")
}
// Выведет "Не было возможности установить адрес."
