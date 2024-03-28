//
//  Person.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 26.03.2024.
//
import Foundation

struct Person: Decodable {
    let name: String
    let photo: String
    let birthday: String
    let countAwards: Int
    let death: String?
    
    var birthdayInFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        return formatter.string(
            from: formatter.date(from: birthday) ?? Date()
        )
    }
}
