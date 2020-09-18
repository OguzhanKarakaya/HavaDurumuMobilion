//
//  SelectedCityDetailModel.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation

struct SelectedCityDetailModel {
    var cityName: String?
    var temp: NSNumber?
    var cloud: String?
    
    init(cityName: String, temp: NSNumber, cloud: String) {
        self.cityName = cityName
        self.temp = temp
        self.cloud = cloud
    }
}
