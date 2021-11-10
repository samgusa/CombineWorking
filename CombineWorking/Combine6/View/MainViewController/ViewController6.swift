//
//  ViewController6.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/25/21.
//

import UIKit

class ViewController6: UIViewController {
    
    let tblView = UITableView()
    
    var tableData = [String]()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .systemBackground
        print("6")
        tblView.delegate = self
        tblView.dataSource = self
        combineSync()
        addTable()
        
    }
    
    func addTable() {
        view.addSubview(tblView)
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell6")
        
        NSLayoutConstraint.activate([
            tblView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tblView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tblView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tblView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    
    func combineSync() {
        CombineFile6.shared.fetchDogs()
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.present(AlertController6.shared.createAlert(error: "Can't get data for tableView"), animated: true, completion: nil)
                }
            } receiveValue: { [weak self] (value) in
                for i in value.message {
                    self?.tableData.append(i.key)
                    self?.tblView.reloadData()
                }
            }
            .store(in: &CombineFile6.shared.subscriptions)

    }
}
