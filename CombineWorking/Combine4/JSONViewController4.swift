//
//  JSONViewController4.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/24/21.
//

import UIKit
import Combine

class JSONViewController4: UIViewController {

    var imgView: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return img
    }()
    
    
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(imgView)
        APICaller.shared.passData
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
                self?.imgView.image = UIImage(named: value)
            }
            .store(in: &APICaller.shared.subscription)

        
        setUp()
        
        
    }
    
    func setUp() {
        
        NSLayoutConstraint.activate([
            imgView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imgView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            imgView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        ])
        
    }

   

}
