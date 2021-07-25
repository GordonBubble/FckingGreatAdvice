//
//  Model.swift
//  FckingGreatAdvice
//
//  Created by Mac on 12.07.2021.
//

import Foundation
import RealmSwift

struct ModelAdvice: Codable {
    
    var id: Int
    var text: String
    
}

class ModelDB: Object {
    
    @objc dynamic var id = "0"
    @objc dynamic var text = ""

    
}
