//
//  ViewController10.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/31/21.
//

import UIKit
import Combine

class ViewController10: UIViewController {
    
    
    private let commentTxt: UITextView = {
        let txt = UITextView()
        txt.layer.borderColor = UIColor.label.cgColor
        txt.layer.borderWidth = 1
        txt.layer.cornerRadius = 8
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    
    private let commentBtn: UIButton = {
       let btn = UIButton()
        btn.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Comment", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .preferredFont(forTextStyle: .body)
        UIFont.boldSystemFont(ofSize: btn.titleLabel?.font.pointSize ?? 0.0)
        return btn
    }()
    
    private let formContainerStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var accountViewModel = AccountViewModel9()
    
    private lazy var commentsViewModel = CommentsViewModel9(manager: accountViewModel)
   
    private var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        setUp()
        accountSubscription()
    }
    

    @objc func btnPressed() {
        commentsViewModel.send(comment: commentTxt.text)
    }
    
    
}


private extension ViewController10 {
    
    func setUp() {
        
        formContainerStack.addArrangedSubview(commentTxt)
        formContainerStack.addArrangedSubview(commentBtn)
        
        view.addSubview(formContainerStack)
        
        NSLayoutConstraint.activate([
            commentBtn.heightAnchor.constraint(equalToConstant: 44),
            commentTxt.heightAnchor.constraint(equalToConstant: 150),
            formContainerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            formContainerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            formContainerStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44)
        ])
    }
    
    
    func accountSubscription() {
        
        accountViewModel
            .userAccountStatus
            .sink { [weak self] (status) in
                guard let self = self else { return }
                
                if status == .banned {
                    self.showBlocked()
                }
            }
            .store(in: &subscriptions)
    }
}
