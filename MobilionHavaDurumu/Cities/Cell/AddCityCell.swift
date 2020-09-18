//
//  AddCityCell.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

class AddCityCell: UITableViewCell {

    @IBOutlet var lblAddCity: UILabel!
    var cityId: String?
    var cityArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddCity(_ sender: Any) {
        let oldArray = userDefaults.stringArray(forKey: selectedCitiesUserDefaults)
        if oldArray != nil {
            for i in 0..<oldArray!.count {
                self.cityArray.append(oldArray![i])
            }
        }
        self.cityArray.append(cityId!)
        userDefaults.set(self.cityArray, forKey: selectedCitiesUserDefaults)
    }

}
