//
//  GeneralCityModel.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SwiftyJSON

struct GeneralCityModel {
    var id: NSNumber?
    var name: String?
    var coordinat: Coordinats?
    var country: String?
    var population: NSNumber?
    var timeZone: NSNumber?
    var sunrise: NSNumber?
    var sunset: NSNumber?
    
    init(dict: [String: JSON]) {
        self.id = dict["id"]?.numberValue
        self.name = dict["name"]?.stringValue
        self.coordinat = Coordinats(dict: (dict["coord"]?.dictionaryObject)!)
        self.country = dict["country"]?.stringValue
        self.population = dict["population"]?.numberValue
        self.timeZone = dict["timezone"]?.numberValue
        self.sunrise = dict["sunrise"]?.numberValue
        self.sunset = dict["sunset"]?.numberValue
    }
}

struct Coordinats {
    var lat: NSNumber?
    var long: NSNumber?
    
    init(dict: [String: Any]) {
        self.lat = dict["lat"] as? NSNumber
        self.long = dict["lon"] as? NSNumber
    }
}
