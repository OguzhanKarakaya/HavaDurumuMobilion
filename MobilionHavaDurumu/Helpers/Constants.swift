//
//  Constants.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import Alamofire

var manager: SessionManager = Alamofire.SessionManager.init()
let userDefaults = UserDefaults.standard

var API_KEY = "d66b008ac299403e6603775cd163b1b9"
var WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast?id=%s&appid=d66b008ac299403e6603775cd163b1b9"
var CITIES_URL = "https://weathercase-99549.firebaseio.com/.json"
let selectedCitiesUserDefaults = "SelectedCities"
let SERVER_ERROR_MESSAGE = "Sunucuya bağlantı hatası oluştu"

