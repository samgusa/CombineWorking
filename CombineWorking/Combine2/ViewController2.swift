//
//  ViewController2.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/21/21.
//

import UIKit

class ViewController2: UIViewController {

    var viewModel = CombineViewModel2()
    
    private let tablView: UITableView = {
       let tbl = UITableView()
        tbl.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tablView)
        tablView.dataSource = self
        tablView.frame = view.bounds
        
        viewModel.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] users in
                self?.viewModel.users = users
                self?.tablView.reloadData()
            })
            .store(in: &viewModel.subscription)
        print("2")
    }

}


extension ViewController2: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = viewModel.users[indexPath.row].name
        
        return cell
    }
    
    
}
