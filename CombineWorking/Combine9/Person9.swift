//
//  Person9.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/30/21.
//

import Foundation

struct Person9 {
    var firstName: String
    var lastName: String
    var occupation: String
}

extension Person9 {
    
    var message: String {
        "\(firstName) \(lastName) is a \(occupation)"
    }
    
    var isValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !occupation.isEmpty
    }
}
