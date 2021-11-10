//
//  CommentsViewModel9.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/31/21.
//

import Foundation
import Combine


final class CommentsViewModel9 {
    
    private var commentsEntered = PassthroughSubject<String, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    private var badWords = ["Poop", "Eggplant"]
    
    private let manager: AccountViewModel9
    
    init(manager: AccountViewModel9) {
        self.manager = manager
        setupSubscriptions()
    }
    
    func send(comment: String) {
        commentsEntered.send(comment)
    }
    
    
}

private extension CommentsViewModel9 {
    func setupSubscriptions() {
        
        commentsEntered
            .filter { !$0.isEmpty }
            .sink { [weak self] (val) in
                guard let self = self else { return }
                
                if self.badWords.contains(val) {
                    self.manager.increaseWarnings()
                } else {
                    print("New Comments: \(val)")
                }
            }
            .store(in: &subscriptions)
    }
}
