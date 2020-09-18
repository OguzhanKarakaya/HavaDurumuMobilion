//
//  CitiesVC.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

class CitiesVC: UIViewController {

    @IBOutlet var tableView: UITableView!
        
        var generalModel: GeneralModel?
        var weatherInfoArray = [WeatherModel]()
        var selectedCitiesNames = [String]()
        var selectedCityID: String?
        var selectedCityDetailModel = [SelectedCityDetailModel]()
        let date = Date()
        var todaysDateHumanRead: String?
        let formatterHumanRead = DateFormatter()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            formatterHumanRead.dateFormat = "dd.MM.yyyy"
            self.todaysDateHumanRead = formatterHumanRead.string(from: date)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            
            let selectedCitiesArray = userDefaults.stringArray(forKey: selectedCitiesUserDefaults)
            if selectedCitiesArray!.count > 0 {
                for i in 0..<selectedCitiesArray!.count {
                    selectedCityID = selectedCitiesArray![i]
                    getCity(selectedCity: selectedCityID!)
                }
            }
            
        }
        
        func getCity(selectedCity: String) {
            self.weatherInfoArray.removeAll()
            self.selectedCityDetailModel.removeAll()
            RestController().getWeathers(selectedCityId: selectedCity) {
                result in
                if result.code == 200 {
                    self.generalModel = GeneralModel(dict: result.response!)
                    self.weatherInfoArray = self.generalModel!.list
                    self.selectedCitiesNames.append((self.generalModel?.city!.name)!)
                    self.selectedCityDetailModel.append(SelectedCityDetailModel(cityName: (self.generalModel?.city!.name)!, temp: (self.generalModel?.list[0].main!.temp)!, cloud: (self.generalModel?.list[0].weather[0].main)!))
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }

    extension CitiesVC: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return selectedCityDetailModel.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "citiesCell") as! CitiesCell
            
            cell.lblCityName.text = selectedCityDetailModel[indexPath.row].cityName
            cell.lblTemp.text = SessionParameters.shared.kelvinToCelcius(temp: selectedCityDetailModel[indexPath.row].temp!)
            cell.lblDate.text = todaysDateHumanRead
            
            switch selectedCityDetailModel[indexPath.row].cloud {
            case "Clear":
                cell.ivWeather.image = UIImage(named: "ic_sun")
                break
            case "Snow":
                cell.ivWeather.image = UIImage(named: "ic_snow")
                break
            case "Clouds":
                cell.ivWeather.image = UIImage(named: "ic_dark")
                break
            default:
                cell.ivWeather.image = UIImage(named: "ic_sun")
            }
                    
            
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if (editingStyle == .delete) {
                selectedCityDetailModel.remove(at: indexPath.row)
                self.tableView.reloadData()
                // handle delete (by removing the data from your array and updating the tableview)
            }
        }
    }
