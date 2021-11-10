//
//  ViewController11.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/31/21.
//

import UIKit
import Combine

class ViewController11: UIViewController {

    private let contentImgView: UIImageView = {
       let img = UIImageView()
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .systemGray4
        img.layer.cornerRadius = 8
        return img
    }()
    
    
    private let downloadBtn: UIButton = {
       let btn = UIButton()
        btn.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Download", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .preferredFont(forTextStyle: .body)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: btn.titleLabel?.font.pointSize ?? 0.0)
        return btn
    }()
    
    private let contentContainerStackVW: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private let imgLink = "https://blueprint-api-production.s3.amazonaws.com/uploads/story/thumbnail/121489/11a49146-03e6-4f02-8c30-ac3454a1b54b.png"
    
    private let imgDownloaderViewModel = ImageDownloaderViewModel11()
    private var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .systemBackground
        print(11)
        setup()
        setupImageSubscription()
    }
    

    @objc func btnPressed() {
        imgDownloaderViewModel.download(url: imgLink)
    }
   
}

private extension ViewController11 {
    
    func setup() {
        contentContainerStackVW.addArrangedSubview(contentImgView)
        contentContainerStackVW.addArrangedSubview(downloadBtn)
        
        view.addSubview(contentContainerStackVW)
        
        
        NSLayoutConstraint.activate([
            downloadBtn.heightAnchor.constraint(equalToConstant: 44),
            contentImgView.heightAnchor.constraint(equalToConstant: 150),
            
            contentContainerStackVW.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentContainerStackVW.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentContainerStackVW.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentContainerStackVW.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    
    func setupImageSubscription() {
        imgDownloaderViewModel
            .image
            .assign(to: \.image, on: contentImgView)
            .store(in: &subscriptions)
    }
}
