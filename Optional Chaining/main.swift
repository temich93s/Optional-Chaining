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


//MARK: Доступ к сабскриптам через ОП
print("\n//Доступ к сабскриптам через ОП")

if let firstRoomName = john1.residence?[0].name {
    print("Название первой комнаты \(firstRoomName).")
} else {
    print("Никак не получить название первой комнаты.")
}
// Выведет "Никак не получить название первой комнаты."

//john.residence? все еще nil, потому что код справа после присваивания не вычисляется
john1.residence?[0] = Room1(name: "Bathroom")
print(john1.residence?[0])

let johnsHouse = Residence1()
johnsHouse.rooms.append(Room1(name: "Гостиная"))
johnsHouse.rooms.append(Room1(name: "Кухня"))
john1.residence = johnsHouse
 
if let firstRoomName = john1.residence?[0].name {
    print("Название первой комнаты \(firstRoomName).")
} else {
    print("Никак не получить название первой комнаты.")
}
// Выведет "Название первой комнаты Гостиная."

//код выполняется так как уже не nil
john1.residence?[0] = Room1(name: "Bathroom")
print(john1.residence?[0].name)
print(john1.residence![0].name)


//MARK: Получение доступа к сабскрипту (индексу) опционального типа
print("\n//Получение доступа к сабскрипту (индексу) опционального типа")

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
print(testScores["Bev"]?[0] += 1)
print(testScores["Brian"]?[0] = 72)
print(testScores)
// массив "Dave" теперь имеет вид [91, 82, 84], массив "Bev" - [80, 94, 81]


//MARK: Соединение нескольких уровней ОП
print("\n//Соединение нескольких уровней ОП")

if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Выведет "Unable to retrieve the address."

let johnsAddress = Address1()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john1.residence?.address = johnsAddress
 
if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Выведет "John's street name is Laurel Street."


//MARK: Связывание методов в ОП с опциональными возвращаемыми значениями
print("\n//Связывание методов в ОП с опциональными возвращаемыми значениями")

if let buildingIdentifier = john1.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// Выведет "John's building identifier is The Larches."

if let beginsWithThe = john1.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
// Выведет "John's building identifier begins with "The"."

print(john1.residence?.address?.buildingIdentifier())
print(john1.residence?.address?.buildingIdentifier()!)
