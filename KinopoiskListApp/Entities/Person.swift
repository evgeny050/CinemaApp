//
//  Person.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 26.03.2024.
//
import Foundation

struct Person: Decodable {
    let id: Int
    let name: String
    let enName: String?
    let photo: String
    let birthday: String
    let death: String?
    let age: Int
    let growth: Int
    let profession: [Profession]
    let facts: [Profession]
    
    var fullName: String {
        return name.replacingOccurrences(of: " ", with: "\n")
    }
    
    var birthdayInFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        return formatter.string(
            from: formatter.date(from: birthday) ?? Date()
        )
    }
}

struct Profession: Decodable {
    let value: String
}
