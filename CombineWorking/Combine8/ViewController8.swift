//
//  ViewController8.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/30/21.
//

import UIKit

class ViewController8: UIViewController {

    private let inputTxtField: UITextField = {
       let txt = UITextField()
        txt.placeholder = "Enter some text here"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.borderStyle = .roundedRect
        return txt
    }()
    
    
    private let txtLbl: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "The user entered:"
        lbl.font = .preferredFont(forTextStyle: .title1)
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        print("8")
        setup()
        setupSubscription()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController8 {
    
    func setup() {
        view.addSubview(inputTxtField)
        view.addSubview(txtLbl)
        
        NSLayoutConstraint.activate([
            inputTxtField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inputTxtField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputTxtField.heightAnchor.constraint(equalToConstant: 44),
            inputTxtField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            txtLbl.topAnchor.constraint(equalTo: inputTxtField.bottomAnchor, constant: 16),
            txtLbl.leadingAnchor.constraint(equalTo: inputTxtField.leadingAnchor),
            txtLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    
    func setupSubscription() {
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: inputTxtField)
            .compactMap { ($0.object as? UITextField)?.text }
            .map { "The User entered \($0)" }
            .assign(to: \.text, on: txtLbl)
            .store(in: &CombineFile8.shared.subscriptions)
    }
    
}
