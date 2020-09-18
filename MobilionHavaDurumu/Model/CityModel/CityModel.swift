//
//  CityModel.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CityModel {
    var id: NSNumber?
    var name: String?
    var state: String?
    var country: String?
    
    init(id: NSNumber, name: String, state: String, country: String) {
        self.id = id
        self.name = name
        self.state = state
        self.country = country
    }
}

