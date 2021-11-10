//
//  CombineFile9.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/30/21.
//

import Foundation
import Combine


class CombineFile9 {
    
    static let shared = CombineFile9()
    
    let person = CurrentValueSubject<Person9, Error>(Person9(firstName: "", lastName: "", occupation: ""))
    
    var subscription = Set<AnyCancellable>()
    
}
