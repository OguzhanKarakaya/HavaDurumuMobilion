//
//  SessionParameters.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class SessionParameters{
    static let shared = SessionParameters()
    private init(){}
    
    var weatherList: [JSON]?
    var cityList = [CityModel]()
    
    var selectedCityIds = [String]()
    var selectedCities = [CityModel]()
    
    func kelvinToCelcius(temp: NSNumber) -> String{
        let value = String(format: "%.0f", temp.doubleValue - 273.15) + "\u{00B0}C"
        return value
    }
}
