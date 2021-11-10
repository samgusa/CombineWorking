//
//  AlertController6.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/25/21.
//

import Foundation
import UIKit


protocol CreateAlert6 {
    func createAlert(error: String) -> UIAlertController
}


class AlertController6: CreateAlert6 {
    
    static let shared = AlertController6()
    
    
    func createAlert(error: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        return alert
    }
    
}
