//
//  CombineViewModel1.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/20/21.
//

import Foundation
import Combine


protocol CombineViewModelProtocol1 {
    
    var action: PassthroughSubject<String, Never> { get set }
    
    var model: [String] { get set }
    
    var subscriber: Set<AnyCancellable> { get set }
    
}


class CombineViewModel1: CombineViewModelProtocol1 {
    
    static let shared = CombineViewModel1()
    
    
    var action: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    
    var model: [String] = []
    
    var subscriber: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func create() {
        fetchCompanies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] (value) in
                self?.model = value
            })
            .store(in: &subscriber)
    }
    
    func fetchCompanies() -> Future<[String], Error> {
        
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                promise(.success(["Apple", "Google", "Facebook", "Microsoft", "Uber", "HP", "Sony"]))
            }
        }
        
    }
    
}
