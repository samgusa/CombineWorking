//
//  AddViewController5.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/24/21.
//

import UIKit

class AddViewController5: UIViewController {

    
    var itemTxtField: UITextField = {
       let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.label.cgColor
        txt.layer.cornerRadius = 8
        txt.textAlignment = .center
        return txt
    }()
    
    
    var doneBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        btn.setTitle("Done", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        addView()
    }
    
    
    @objc func btnTapped() {
        print("Done")
        CombineFile5.shared.newItem.send(itemTxtField.text ?? "")
        self.dismiss(animated: true, completion: nil)
    }

    
    func addView() {
        self.view.addSubview(itemTxtField)
        self.view.addSubview(doneBtn)
        
        NSLayoutConstraint.activate([
            itemTxtField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25),
            itemTxtField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            itemTxtField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            itemTxtField.heightAnchor.constraint(equalToConstant: 40),
            doneBtn.topAnchor.constraint(equalTo: itemTxtField.bottomAnchor, constant: 10),
            doneBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
    }

}
