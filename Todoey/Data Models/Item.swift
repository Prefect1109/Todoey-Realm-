//
//  Item.swift
//  Todoey
//
//  Created by Богдан Ткачук on 07.03.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dataCreated: Date?
    @objc dynamic var colour: String = ""
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
