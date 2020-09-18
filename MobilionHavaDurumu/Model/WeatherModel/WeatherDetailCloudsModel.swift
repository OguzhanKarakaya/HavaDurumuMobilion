//
//  WeatherDetailCloudsModel.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
struct WeatherDetailCloudsModel {
    var all: String?
    
    init(dict: [String: Any]) {
        self.all = dict["all"] as? String
    }
}
