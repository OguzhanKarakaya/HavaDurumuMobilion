//
//  GeneralModel.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SwiftyJSON

struct GeneralModel {
    var code: String?
    var message: NSNumber?
    var cnt: NSNumber?
    var list = [WeatherModel]()
    var city: GeneralCityModel?
    
    init(dict: [String: JSON]) {
        self.code = dict["cod"]?.stringValue
        self.message = dict["message"]?.numberValue
        self.cnt = dict["cnt"]?.numberValue
        if let listArray = dict["list"]?.arrayValue{
            listArray.forEach({ i in
                if let listItem = i.dictionary {
                    let currentListItem = WeatherModel(dict: listItem)
                    list.append(currentListItem)
                }
            })
        }
        self.city = GeneralCityModel(dict: (dict["city"]?.dictionary)!)
    }
}
