//
//  CitiesCell.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

class CitiesCell: UITableViewCell {

    @IBOutlet var ivWeather: UIImageView!
    @IBOutlet var lblCityName: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTemp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
