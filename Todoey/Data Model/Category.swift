//
//  Category.swift
//  Todoey
//
//  Created by Onur İpekboyayan on 7.12.2018.
//  Copyright © 2018 Onur İpekboyayan. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    //forward relationship:
    let items = List<Item>()
    
}
