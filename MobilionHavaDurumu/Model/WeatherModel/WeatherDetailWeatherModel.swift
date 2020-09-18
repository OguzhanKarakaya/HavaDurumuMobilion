//
//  WeatherDetailWeatherModel.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherDetailWeatherModel {
    var id: NSNumber?
    var main: String?
    var description: String?
    var icon: String?
    
    init(dict: [String: JSON]) {
        self.id = dict["id"]?.numberValue
        self.main = dict["main"]?.stringValue
        self.description = dict["description"]?.stringValue
        self.icon = dict["icon"]?.stringValue
    }
}
