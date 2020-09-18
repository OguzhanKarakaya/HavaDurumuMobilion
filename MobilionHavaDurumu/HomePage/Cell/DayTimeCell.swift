//
//  DayTimeCell.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

class DayTimeCell: UICollectionViewCell {
    
    @IBOutlet var lblDayTime: UILabel!
    @IBOutlet var icDayTime: UIImageView!
    @IBOutlet var uiview: UIView!
    
    override var isSelected: Bool {
        didSet {
            self.uiview.backgroundColor = isSelected ? UIColor.init(red: 117/255, green: 3/255, blue: 253/255, alpha: 1) : UIColor.white
        }
    }
    
}

