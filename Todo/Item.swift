//
//  Item.swift
//  Todo
//
//  Created by Shubham Shukla on 27/06/23.
//

import Foundation
class  Item : Codable {
    var task : String
    var done : Bool
    init (t : String , d : Bool)
    {
        self.task = t
        self.done = d
    }
}
