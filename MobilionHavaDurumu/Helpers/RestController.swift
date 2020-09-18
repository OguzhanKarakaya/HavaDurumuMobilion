//
//  RestController.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RestController {
    
    public func get(url: String, completion: @escaping (_ resultCode: Int,_ response: [String: JSON]?)->()){
        let request = manager.request(url, method: .get, encoding: JSONEncoding.default)
        request.responseJSON{ response in
            let statusCode = response.response?.statusCode ?? 500
            if let data = response.data {
                do{
                    let json = try JSON(data:data).dictionary
                    if let json = json {
                        completion(statusCode, json)
                    }else {
                        completion(statusCode, nil)
                    }
                }catch {
                    completion(statusCode, nil)
                }
            }else{
                completion(statusCode, nil)
            }
        }
    }
    
    func getWeathers(selectedCityId: String, completion: @escaping (_ result: RestControllerResultWDictData) -> ()) {
        let url = WEATHER_URL.replacingOccurrences(of: "%s", with: selectedCityId)
        get(url: url) {
            (statusCode, response) in
            if let response = response {
                if statusCode == 200 {
                    let generalItem = response
                    completion(RestControllerResultWDictData(code: statusCode, response: generalItem))
                } else {
                    completion(RestControllerResultWDictData(code: statusCode, message: SERVER_ERROR_MESSAGE))
                }
            }
        }
    }
    
    func getCities(completion: @escaping (_ result: RestControllerResultWData) -> ()) {
        let request = manager.request(CITIES_URL, method: .get, encoding: JSONEncoding.default)
        request.responseJSON{
            response in
            if response.response?.statusCode == 200 {
                if let result = response.result.value{
                    let json = JSON(result)
                    var citiesArray = [CityModel]()
                    
                    for i in 0..<json.array!.count{
                        if let dict = json[i].rawValue as? NSDictionary {
                            let country = dict["country"] as! String
                            let id = dict["id"] as! NSNumber
                            let name = dict["name"] as! String
                            let state = dict["state"] as! String
                            citiesArray.append(CityModel(id: id, name: name, state: state, country: country))
                        }
                    }
                    SessionParameters.shared.cityList = citiesArray
                    completion(RestControllerResultWData(code: response.response!.statusCode, response: citiesArray as AnyObject))
                } else {
                    completion(RestControllerResultWData(code: response.response!.statusCode, message: SERVER_ERROR_MESSAGE))
                }
            } else {
                completion(RestControllerResultWData(code: response.response!.statusCode, message: SERVER_ERROR_MESSAGE))
            }
        }
    }
}
