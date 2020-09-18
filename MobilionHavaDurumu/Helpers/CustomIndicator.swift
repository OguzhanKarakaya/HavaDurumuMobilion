//
//  CustomIndicator.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import UIKit

class CustomIndicator{
    
    static let container: UIView = UIView()
    static var loadingView: UIView = UIView()
    static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    static func showActivityIndicator(uiView:UIView){
        
        container.frame = UIScreen.main.fixedCoordinateSpace.bounds
        container.center = CGPoint(x:UIScreen.main.fixedCoordinateSpace.bounds.width / 2, y: UIScreen.main.fixedCoordinateSpace.bounds.height / 2)
        container.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x:0, y:0, width:80, height:80)
        loadingView.center = container.center
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x:0.0, y:0.0, width:40.0, height:40.0);
        actInd.style = .whiteLarge
        actInd.color = UIColor.gray
        actInd.center = CGPoint(x:loadingView.frame.size.width / 2,
                                y:loadingView.frame.size.height / 2);

        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
        
    }
    
    static func showWithoutContainer(uiView: UIView){
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x:0.0, y:0.0, width:40.0, height:40.0);
        actInd.style = .whiteLarge
        actInd.color = UIColor.gray
        actInd.center = uiView.center;
        uiView.addSubview(actInd)
        actInd.startAnimating()
    }
    
    static func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
}

