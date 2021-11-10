//
//  ViewController9.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/30/21.
//

import UIKit

class ViewController9: UIViewController {

    private let firstNameTxtField: UITextField = {
       let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "First Name"
        txt.borderStyle = .roundedRect
        return txt
    }()
    
    private let lastNameTxtField: UITextField = {
       let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Last Name"
        txt.borderStyle = .roundedRect
        return txt
    }()
    
    private let occupationNameTxtField: UITextField = {
       let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Occupation"
        txt.borderStyle = .roundedRect
        return txt
    }()
    
    private let confirmBtn: UIButton = {
       let btn = UIButton()
        btn.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Confirm", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: btn.titleLabel?.font.pointSize ?? 0.0)
        return btn
    }()
    
    private let formContainerStackVW: UIStackView = {
       let stack = UIStackView()
        stack.spacing = 16
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .systemBackground
        print("9")
        setup()
        setupInputSubscriptions()
        setupPersonDescription()
    }
    

    @objc func btnPressed() {
        if CombineFile9.shared.person.value.isValid {
            CombineFile9.shared.person.send(completion: .finished)
        } else {
            self.showFailed(message: UserError9.invalid.errorDescription)
        }
    }

}

extension ViewController9 {
    
    func setup() {
        
        formContainerStackVW.addArrangedSubview(firstNameTxtField)
        formContainerStackVW.addArrangedSubview(lastNameTxtField)
        formContainerStackVW.addArrangedSubview(occupationNameTxtField)
        formContainerStackVW.addArrangedSubview(confirmBtn)
        
        view.addSubview(formContainerStackVW)
        
        NSLayoutConstraint.activate([
            formContainerStackVW.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            formContainerStackVW.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            formContainerStackVW.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formContainerStackVW.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        formContainerStackVW
            .arrangedSubviews
            .forEach { $0.heightAnchor.constraint(equalToConstant: 44).isActive = true }
    }
    
    
    func setupInputSubscriptions() {
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: firstNameTxtField)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] (value) in
                CombineFile9.shared.person.value.firstName = value
            }
            .store(in: &CombineFile9.shared.subscription)
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: lastNameTxtField)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] (value) in
                CombineFile9.shared.person.value.lastName = value
            }
            .store(in: &CombineFile9.shared.subscription)
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: lastNameTxtField)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] (value) in
                CombineFile9.shared.person.value.occupation = value
            }
            .store(in: &CombineFile9.shared.subscription)
    }
    
    func setupPersonDescription() {
        CombineFile9.shared.person
            .sink { [weak self] _ in
                print("Final input: \(CombineFile9.shared.person.value.message ?? "")")
            } receiveValue: { (person) in
                print(CombineFile9.shared.person)
            }
            .store(in: &CombineFile9.shared.subscription)
    }
    
    
    
}
