//
//  CombineFile5.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/24/21.
//

import Foundation
import Combine

class CombineFile5 {
    
    static let shared = CombineFile5()
    
    var subscription = Set<AnyCancellable>()
    
    let newItem = PassthroughSubject<String, Never>()
}
