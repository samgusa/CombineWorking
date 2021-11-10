//
//  Bundle-Decodable.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/24/21.
//

import Foundation
import Combine

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle. \(LocalizedError.self)")
        }
        
        return loaded
    }
}

class CombineViewModel4 {
    
    static let shared = CombineViewModel4()
    
    var changedImg = ""
    
    var imageName = "".publisher
    
    private var subscription = Set<AnyCancellable>()
    
    
    func fetchData() {
        
        imageName
            .receive(on: DispatchQueue.main)
            .map({$0})
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] (value) in
                self?.changedImg = value.description
            }
            .store(in: &subscription)

        
    }
}

class APICaller {
    
    static let shared = APICaller()
    
    var subscription = Set<AnyCancellable>()
    
    var passData = PassthroughSubject<String, Never>()
    
    func fetchData() -> Future<[AnimalCombine4], Error> {
        return Future { promise in
            let bundleAnimal: [AnimalCombine4] = Bundle.main.decode([AnimalCombine4].self, from: "otherTest.json")
            promise(.success(bundleAnimal))
        }
    }
    
}
