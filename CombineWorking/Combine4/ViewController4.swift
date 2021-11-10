//
//  ViewController4.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/24/21.
//

import UIKit

class MyCustomCombineCell4: UITableViewCell {
    
}


class ViewController4: UIViewController {

    private var models = [AnimalCombine4]()
    
    private let tableView: UITableView = {
       let tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.register(MyCustomCombineCell4.self, forCellReuseIdentifier: "Cell4")
        return tbl
    }()
    
    
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        self.view.backgroundColor = .systemBackground
        print("4")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.frame
        APICaller.shared.fetchData()
            .receive(on: DispatchQueue.main)
            .map({$0})
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] (value) in
                self?.models = value
                self?.tableView.reloadData()
            }
            .store(in: &APICaller.shared.subscription)

    }
    

    
}

extension ViewController4: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath) as? MyCustomCombineCell4 else { fatalError() }
        cell.textLabel?.text = models[indexPath.row].title
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(models[indexPath.row].image)
        let vc = JSONViewController4()
        self.present(vc, animated: true, completion: nil)
        APICaller.shared.passData.send(models[indexPath.row].image)
       
        
        
    }
    
    
    
    
    
    
}

