//
//  ViewController3.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/22/21.
//

import UIKit
import Combine


class ViewController3: UIViewController {

    private let stackView: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 16
        return stack
    }()
    
    private let txtField: UITextField = {
       let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "New Blog Post"
        txt.borderStyle = .roundedRect
        return txt
    }()
    
    
    private let lineView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        return view
    }()
    
    private var publishBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        btn.layer.cornerRadius = 8.0
        btn.setTitle("Publish", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        return btn
    }()
    
    private var subscriptionLbl: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Subscriber"
        lbl.textColor = .label
        lbl.font = .preferredFont(forTextStyle: .title2)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        print("3")
        setUp()
        
        let publisher = NotificationCenter.Publisher(center: .default, name: .newBlogPost, object: nil)
            .map { (notification) -> String? in
                return (notification.object as? BlogPost)?.title ?? ""
            }
        let subscriber = Subscribers.Assign(object: subscriptionLbl, keyPath: \.text)
        publisher.subscribe(subscriber)
        
    }
    

    @objc func btnPressed() {
        let title = txtField.text ?? "Coming soon"
        let blogPost = BlogPost(title: title)
        NotificationCenter.default.post(name: .newBlogPost, object: blogPost)
    }

}

extension ViewController3 {
    
    func setUp() {
        stackView.addArrangedSubview(txtField)
        stackView.addArrangedSubview(publishBtn)
        view.addSubview(stackView)
        view.addSubview(lineView)
        view.addSubview(subscriptionLbl)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            lineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            lineView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            subscriptionLbl.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            subscriptionLbl.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            subscriptionLbl.heightAnchor.constraint(equalTo: self.stackView.heightAnchor, multiplier: 0.5),
            subscriptionLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
        
        
    }
}
