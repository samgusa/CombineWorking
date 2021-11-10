//
//  ViewController.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/20/21.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private let tblView: UITableView = {
       let tbl = UITableView()
        tbl.register(CombineCell1.self, forCellReuseIdentifier: "Cell")
        return tbl
    }()
    
    var viewModel = CombineViewModel1()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tblView)
        self.tblView.dataSource = self
        tblView.frame = view.bounds
        print("1")
        viewModel.fetchCompanies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] (value) in
                self?.viewModel.model = value
                self?.tblView.reloadData()
            })
            .store(in: &viewModel.subscriber)
        
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CombineCell1 else {
            fatalError()
        }
        
        cell.viewModel.action.sink { (string) in
            print("\(string) \(indexPath.row)")
        }
        .store(in: &viewModel.subscriber)
        
        return cell
    }
    
    
}

