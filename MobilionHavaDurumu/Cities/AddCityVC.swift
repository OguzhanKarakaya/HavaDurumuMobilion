//
//  AddCityVC.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

class AddCityVC: UIViewController {
    
    var cities = [CityModel]()
    var headerArray = [String]()
    var newArray = [CityModel]()
    var searchingCityList = [CityModel]()
    var searching = false
    
    @IBOutlet var tableView: UITableView!
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 400, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.lightGray
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        
        searchBar.delegate = self
        searchBar.placeholder = "Ara"
        let rightNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        
        getCities()
    }
    
    func getCities() {
        RestController().getCities() {
            result in
            if result.code == 200 {
                self.cities = result.response as! [CityModel]
                //self.getHeader()
                self.tableView.reloadData()
            }
        }
    }
}

extension AddCityVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchingCityList.count
        } else {
            return cities.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addCityCell") as! AddCityCell
        if searching {
            cell.lblAddCity.text = searchingCityList[indexPath.row].name
            cell.cityId = (searchingCityList[indexPath.row].id!).stringValue
        } else {
            cell.lblAddCity.text = cities[indexPath.row].name
            cell.cityId = (cities[indexPath.row].id!).stringValue
        }
        
        return cell
    }
    
}

extension AddCityVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingCityList = cities.filter({$0.name!.prefix((searchText.count)) == searchText})
        searching = true
        tableView.reloadData()
    }
}
