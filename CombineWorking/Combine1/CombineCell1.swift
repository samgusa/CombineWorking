//
//  CombineCell1.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/20/21.
//

import UIKit
import Combine

class CombineCell1: UITableViewCell {

    private let button: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = .systemPink
        btn.setTitle("Button", for: .normal)
        btn.setTitleColor(.systemBackground, for: .normal)
        
        return btn
    }()
    
    var viewModel = CombineViewModel1()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func btnPressed() {
        viewModel.action.send("Cool btn was tapped")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 10, y: 3, width: contentView.frame.width - 20, height: contentView.frame.height - 6)
    }

}
