//
//  WeatherDetailMainModel.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
struct WeatherDetailMainModel {
    var temp: NSNumber?
    var temp_min: NSNumber?
    var temp_max: NSNumber?
    var pressure: NSNumber?
    var sea_level: NSNumber?
    var grnd_level: NSNumber?
    var humidity: NSNumber?
    var temp_kf: NSNumber?
    
    init(dict: [String: Any]) {
        self.temp = dict["temp"] as? NSNumber
        self.temp_min = dict["temp_min"] as? NSNumber
        self.temp_max = dict["temp_max"] as? NSNumber
        self.pressure = dict["pressure"] as? NSNumber
        self.sea_level = dict["sea_level"] as? NSNumber
        self.grnd_level = dict["grnd_level"] as? NSNumber
        self.humidity = dict["humidity"] as? NSNumber
        self.temp_kf = dict["temp_kf"] as? NSNumber
    }
}
