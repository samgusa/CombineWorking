//
//  CombineCell5.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/24/21.
//

import UIKit

class CombineCell5: UITableViewCell {

    let testLbl: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .label
        lbl.textAlignment = .center
        lbl.font = .preferredFont(forTextStyle: .body)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(testLbl)
        NSLayoutConstraint.activate([
            testLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            testLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            testLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
