//
//  Person.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 26.03.2024.
//
import Foundation

struct Person: ResponseType {
    let id: Int
    let name: String
    let enName: String?
    let photo: String
    let birthday: String
    let death: String?
    let age: Int
    let profession: [ProfessionOrFact]
    let facts: [ProfessionOrFact]
    
    var fullName: String {
        return name.replacingOccurrences(of: " ", with: "\n")
    }
    
    var birthdayInDateFormat: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY-MM-dd"
        return formatter.date(from: String(birthday.prefix(10))) ?? Date()
    }
    
    var birthdayInFormat: String {
        let startIndex = birthday.index(birthday.startIndex, offsetBy: 5)
        let endIndex =  birthday.index(birthday.startIndex, offsetBy: 6)
        return String(birthday[startIndex...endIndex])
    }
    
    var birthdayRUString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM YYYY"
        let stringDate = dateFormatter.string(from: birthdayInDateFormat)
        return stringDate
    }
    
    var professionsInString: String {
        let profs = profession.map { prof in
            return prof.value
        }
        return profs.prefix(3).joined(separator: ", ")
    }
    
    static var type = "person?"
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case enName
        case photo
        case birthday
        case death
        case age
        case growth
        case profession
        case facts
    }
    
    enum CodingError: Error {
        case decoding(String)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.enName = try container.decodeIfPresent(String.self, forKey: .enName)
        self.photo = try container.decode(String.self, forKey: .photo).replacing("https:https", with: "https")
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.death = try container.decodeIfPresent(String.self, forKey: .death)
        self.age = try container.decode(Int.self, forKey: .age)
        //self.growth = try container.decode(Int.self, forKey: .growth)
        self.profession = try container.decode([ProfessionOrFact].self, forKey: .profession)
        self.facts = try container.decode([ProfessionOrFact].self, forKey: .facts)
    }
    
    func store() {
        print("")
    }
}

struct ProfessionOrFact: Codable {
    let value: String
}
