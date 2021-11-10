//
//  CombineFile6.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/25/21.
//

import Foundation
import Combine
import UIKit


class CombineFile6 {
    
    static let shared = CombineFile6()
    
    private typealias AnyDataImage = AnyPublisher<CombineDogImage6, Error>
    
    var subscriptions = Set<AnyCancellable>()
    
    private let url = URL(string: CombineConstants6.mainCombine)!
    
    var dogImg = PassthroughSubject<UIImage?, Never>()
    
    var imgURL = ""
    
    
    //fetch dog list for tableView
    func fetchDogs() -> AnyPublisher<CombineDogs6, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CombineDogs6.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    //image url fetching
    func downloadImg(url: String) -> AnyPublisher<CombineDogImage6, Error> {
        let urlImg = URL(string: url)!
        return URLSession.shared
            .dataTaskPublisher(for: urlImg)
            .map(\.data)
            .decode(type: CombineDogImage6.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
    
    
    //image fetching
    func download(url: String) {
        guard let urlImg = URL(string: url) else { return }
        
        URLSession
            .shared
            .dataTaskPublisher(for: urlImg)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .handleEvents(receiveSubscription: { (_) in
                print("Starting subscription on main thread: \(Thread.isMainThread)")
                DispatchQueue
                    .main
                    .async {
                        self.dogImg.send(UIImage(named: "placeholder"))
                        print("Setting placeholder on the main thread \(Thread.isMainThread)")
                    }
            })
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { (res) in
                print("Finished subscription on the main thread. \(Thread.isMainThread)")
            } receiveValue: { [weak self] (val) in
                self?.dogImg.send(val)
                print("Received subscription on main thread. \(Thread.isMainThread)")
            }
            .store(in: &subscriptions)
    }
    
}
