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
    
    var birthdayDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.date(from: birthday) ?? Date()
    }
}
