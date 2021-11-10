//
//  SecondViewController6.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/26/21.
//

import UIKit

class SecondViewController6: UIViewController {
    
    
    private var animalImage: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        return img
    }()

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .systemBackground
        print("Second 6")
        syncImage()
        addImage()
    }
    

    func addImage() {
        self.view.addSubview(animalImage)
        
        NSLayoutConstraint.activate([
            animalImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            animalImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            animalImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75)
        ])
    }

    func syncImage() {
        CombineFile6.shared
            .dogImg
            .assign(to: \.image, on: animalImage)
            .store(in: &CombineFile6.shared.subscriptions)
        
        CombineFile6.shared.downloadImg(url: CombineFile6.shared.imgURL)
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.present(AlertController6.shared.createAlert(error: "Can't get data for Image View"), animated: true, completion: nil)
                }
            } receiveValue: { [weak self] (value) in
                CombineFile6.shared.download(url: value.message)
            }
            .store(in: &CombineFile6.shared.subscriptions)

        
    }
    
    
}
