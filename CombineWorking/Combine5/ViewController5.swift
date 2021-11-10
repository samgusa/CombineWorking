//
//  ViewController5.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/24/21.
//

import UIKit

class ViewController5: UIViewController {

    private var tableView: UITableView = {
       let tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.register(CombineCell5.self, forCellReuseIdentifier: "Cell5")
        return tbl
    }()
    
    var items: [String] = ["First", "Second", "Third", "Fourth"]
    
    private var addBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        btn.titleLabel?.font = .preferredFont(forTextStyle: .body)
        btn.setTitleColor(.blue, for: .normal)
        btn.setTitle("Add Item", for: .normal)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        addTbl()
        print("5")
    }
    
    func addTbl() {
        self.view.addSubview(tableView)
        self.view.addSubview(addBtn)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            addBtn.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            addBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            addBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            addBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            addBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func btnPressed() {
        let vc = AddViewController5()
        CombineFile5.shared.newItem
            .handleEvents(receiveOutput: { [unowned self] newItem in
                self.updateTableView(withItem: newItem)
            })
            .sink { (_) in }
            .store(in: &CombineFile5.shared.subscription)
        
        self.present(vc, animated: true, completion: nil)
    }

    func updateTableView(withItem item: String) {
        self.items.append(item)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at:
            [
                .init(row: self.items.count - 1, section: 0)
            ], with: .automatic)
        self.tableView.endUpdates()
    }
    
    
}

extension ViewController5: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell5", for: indexPath) as! CombineCell5
        cell.testLbl.text = items[indexPath.row]
        return cell
    }
    
    
}
