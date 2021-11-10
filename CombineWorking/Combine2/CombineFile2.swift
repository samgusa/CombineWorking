//
//  CombineFile2.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/21/21.
//

import Foundation
import Combine

struct User2: Codable {
    let name: String
}


protocol CombineProtocol2 {
    
    var url: URL? { get set }
    
    var users: [User2] { get set }
    
    var subscription: Set<AnyCancellable> { get set }
}


class CombineViewModel2: CombineProtocol2 {
    
    var url: URL? = URL(string: "https://jsonplaceholder.typicode.com/users")
    
    var users: [User2] = []
    
    var subscription: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchUsers() -> AnyPublisher<[User2], Never> {
        guard let url = url else {
            return Just([])
                .eraseToAnyPublisher()
        }
        //API Call
        
        let publisher = URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [User2].self, decoder: JSONDecoder())
            .catch { (_) in
                Just([])
            }
            .eraseToAnyPublisher()
        return publisher
        
        
    }
    
}
