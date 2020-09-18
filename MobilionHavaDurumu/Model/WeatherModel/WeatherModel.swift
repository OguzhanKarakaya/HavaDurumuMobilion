//
//  WeatherModel.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherModel {
    var dt: NSNumber?
    var main: WeatherDetailMainModel?
    var weather = [WeatherDetailWeatherModel]()
    var clouds: WeatherDetailCloudsModel?
    var wind: WeatherDetailWindModel?
    var dt_txt: String?
    var visibility : NSNumber?
    
    init(dict: [String: JSON]) {
        self.dt = dict["dt"]?.numberValue
        self.main = WeatherDetailMainModel(dict: (dict["main"]?.dictionaryObject)!)
        if let weatherArray = dict["weather"]?.arrayValue{
            weatherArray.forEach({ i in
                if let weatherItem = i.dictionary{
                    let currentWeatherItem = WeatherDetailWeatherModel(dict: weatherItem)
                    weather.append(currentWeatherItem)
                }
            })
        }
        self.clouds = WeatherDetailCloudsModel(dict: (dict["clouds"]?.dictionaryObject)!)
        self.wind = WeatherDetailWindModel(dict: (dict["wind"]?.dictionaryObject)!)
        self.dt_txt = dict["dt_txt"]?.stringValue
        self.visibility = dict["visibility"]?.numberValue
    }
}
