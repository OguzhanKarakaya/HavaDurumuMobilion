//
//  WeatherDetailWindModel.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
struct WeatherDetailWindModel {
    var speed: NSNumber?
    var deg: NSNumber?
    
    init(dict: [String: Any]) {
        self.speed = dict["speed"] as? NSNumber
        self.deg = dict["deg"] as? NSNumber
    }
}
