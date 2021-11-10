//
//  CombineFile8.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/30/21.
//

import Foundation
import Combine

class CombineFile8 {
    
    static let shared = CombineFile8()
    
    var subscriptions = Set<AnyCancellable>()
    
}
