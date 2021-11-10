//
//  ViewController10+Alert.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/31/21.
//

import Foundation
import UIKit

extension ViewController10 {
    
    func showBlocked() {
        
        let alert = UIAlertController(title: "Ooops", message: "Thought you were tough right? Well guess what you're banned", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}
