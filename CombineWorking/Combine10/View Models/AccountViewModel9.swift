//
//  AccountViewModel9.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/31/21.
//

import Foundation
import Combine


final class AccountViewModel9 {
    enum AccountStatus {
        //two states a class can be in
        case active
        case banned
    }
    
    private let warningLimit = 3
    
    let userAccountStatus = CurrentValueSubject<AccountStatus, Never>(.active)
    
    let warnings = CurrentValueSubject<Int, Never>(0)
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        createSubscription()
    }
    
    func increaseWarnings() {
        warnings.value += 1
        print("Warning: \(warnings.value)")
    }
    
}

private extension AccountViewModel9 {
    
    func createSubscription() {
        
        warnings
            .filter({ [weak self] val in
                guard let self = self else { return false }
                return val >= self.warningLimit
            })
            .sink { [weak self] (_) in
                guard let self = self else { return }
                self.userAccountStatus.value = .banned
            }
            .store(in: &subscriptions)
    }
    
}
