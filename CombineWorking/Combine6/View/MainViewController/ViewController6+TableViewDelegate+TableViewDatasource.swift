//
//  ViewController6+TableViewDelegate+TableViewDatasource.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/25/21.
//

import Foundation
import UIKit


extension ViewController6: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "Cell6", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecondViewController6()
        let img = "\(CombineConstants6.combineUrlFirst6)\(tableData[indexPath.row])\(CombineConstants6.combineUrlSecond6)"
        CombineFile6.shared.imgURL = img
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
