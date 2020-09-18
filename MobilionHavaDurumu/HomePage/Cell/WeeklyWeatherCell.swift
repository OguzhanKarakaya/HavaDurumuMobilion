//
//  WeeklyWeatherCell.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

class WeeklyWeatherCell: UITableViewCell {

    @IBOutlet var lblWeekDay: UILabel!
    @IBOutlet var imgWeather: UIImageView!
    @IBOutlet var lblHighest: UILabel!
    @IBOutlet var lblLowest: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
