//
//  RestControllerResult.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import SwiftyJSON

class RestControllerResultWData {
    var code: Int?
    var message: String?
    var response: AnyObject?
    
    required init(code: Int, message: String? = "", response: AnyObject? = nil) {
        self.code = code
        self.message = message
        self.response = response
    }
}

class RestControllerResultWDictData {
    var code: Int?
    var message: String?
    var response: [String: JSON]?
    
    required init(code: Int, message: String? = "", response: [String: JSON]? = nil) {
        self.code = code
        self.message = message
        self.response = response
    }
}
