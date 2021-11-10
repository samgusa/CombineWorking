//
//  ViewController7.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/28/21.
//

import UIKit
import Combine

class ViewController7: UIViewController {
    
    private let countLbl: UILabel = {
       let lbl = UILabel()
        lbl.text = "00:00"
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .largeTitle)
        return lbl
    }()
    
    private let startBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        btn.layer.cornerRadius = 8
        btn.setTitle("Start", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = .preferredFont(forTextStyle: .body)
        return btn
    }()
    
    private let stopBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        btn.layer.cornerRadius = 8
        btn.setTitle("Stop", for: .normal)
        btn.backgroundColor = .systemGray5
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = .preferredFont(forTextStyle: .body)
        return btn
    }()
    
    private let btnContainerStackVw: UIStackView = {
       let stack = UIStackView()
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var subscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        print("7")
        setUp()
        
    }
    
    @objc func startTimer() {
        print("Start")
        //store timer in subscription
        subscription = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .scan(0, { (count, _) in
                return count + 1
            })
            .sink(receiveCompletion: { (_) in
                print("Finished")
                
            }, receiveValue: { [weak self] (count) in
                print("Updating the albel to current value \(count.format)")
                self?.countLbl.text = count.format
            })
        
    }
    
    
    @objc func stopTimer() {
        print("Stop")
        subscription?.cancel()
    }
    
}


private extension ViewController7 {
    
    func setUp() {
        
        btnContainerStackVw.addArrangedSubview(startBtn)
        btnContainerStackVw.addArrangedSubview(stopBtn)
        
        view.addSubview(btnContainerStackVw)
        view.addSubview(countLbl)
        
        
        NSLayoutConstraint.activate([
            countLbl.leadingAnchor.constraint(equalTo: btnContainerStackVw.leadingAnchor),
            countLbl.trailingAnchor.constraint(equalTo: btnContainerStackVw.trailingAnchor),
            countLbl.bottomAnchor.constraint(equalTo: btnContainerStackVw.topAnchor, constant: -24),
            
            btnContainerStackVw.heightAnchor.constraint(equalToConstant: 50),
            btnContainerStackVw.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btnContainerStackVw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        
        ])
        
    }
    
}


extension Int {

    var format: String {

        let (h,m,s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)

        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"

        return "\(h_string):\(m_string):\(s_string)"
    }
}
