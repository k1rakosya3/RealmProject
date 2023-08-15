//
//  Kategory.swift
//  Alert
//
//  Created by Admin on 05.08.23.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    var items = List<Item>()
}
