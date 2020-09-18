//
//  SelectedCityCell.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

class SelectedCityCell: UICollectionViewCell {
    
    @IBOutlet var lblSelectedCityName: UILabel!
    @IBOutlet var uiView: UIView!
    
    override var isSelected: Bool {
        didSet {
            self.uiView.backgroundColor = isSelected ? UIColor.init(red: 117/255, green: 3/255, blue: 253/255, alpha: 1) : UIColor.init(red: 226/255, green: 232/255, blue: 237/255, alpha: 1)
            self.lblSelectedCityName.textColor = isSelected ? UIColor.white : UIColor.darkGray
        }
    }
}

