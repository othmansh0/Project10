//
//  Person.swift
//  Project10
//
//  Created by othman shahrouri on 8/25/21.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

}
