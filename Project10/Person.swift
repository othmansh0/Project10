//
//  Person.swift
//  Project10
//
//  Created by othman shahrouri on 8/25/21.
//

import UIKit
//NSObject it's required to use NSCoding
//protocol requires to implement two methods: a new initializer and encode()

//NSCoder is responsible for encoding (writing) and decoding (reading) your data so that it can be used with UserDefaults

class Person: NSObject,NSCoding {
  
    
    
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
   // required means "if anyone tries to subclass this class, they are required to implement this method
    required init?(coder aDecoder: NSCoder) { //reading out from disk
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
        
    }
    
    func encode(with aCoder: NSCoder) {//writing out to disk
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
        
    }
    
}
