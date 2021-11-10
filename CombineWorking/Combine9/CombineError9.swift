//
//  CombineError9.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/30/21.
//

import Foundation

enum UserError9: Error {
    case invalid
}

extension UserError9 {
    
    public var errorDescription: String {
        switch self {
        case .invalid:
            return "Form is invalid"
        }
    }
}
