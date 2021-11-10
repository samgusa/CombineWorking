//
//  ImageDownloaderViewModel11.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/31/21.
//

import Foundation
import UIKit
import Combine

final class ImageDownloaderViewModel11 {
    let image = PassthroughSubject<UIImage?, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    func download(url: String) {
        guard let urlImg = URL(string: url) else { return }
        
        URLSession
            .shared
            .dataTaskPublisher(for: urlImg)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .handleEvents(receiveSubscription: { _ in
                print("Starting subscription on the main thread: \(Thread.isMainThread)")
                DispatchQueue
                    .main
                    .async {
                        self.image.send(UIImage(named: "placeholder"))
                        print("Setting placeholder on the main thread: \(Thread.isMainThread)")
                    }
            })
            .map{ UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { (res) in
                print("Finished subscription on the main thread. \(Thread.isMainThread)")
                
            } receiveValue: { [weak self] (val) in
                self?.image.send(val)
                self?.image.send(completion: .finished)
                print("Received subscription on main thread. \(Thread.isMainThread)")
            }
            .store(in: &subscriptions)
    }
}
