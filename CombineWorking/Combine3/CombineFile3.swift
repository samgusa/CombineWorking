//
//  CombineFile3.swift
//  CombineWorking
//
//  Created by Sam Greenhill on 10/22/21.
//

import Foundation
import Combine

struct BlogPost {
    let title: String
}

extension Notification.Name {
    static let newBlogPost = Notification.Name("newPost")
}
