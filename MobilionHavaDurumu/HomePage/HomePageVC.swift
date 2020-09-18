//
//  HomePageVC.swift
//  MobilionHavaDurumu
//
//  Created by administrator on 18.09.2020.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var selectedCityCollectionView: UICollectionView!
    @IBOutlet var lblWind: UILabel!
    @IBOutlet var lblGorunurluk: UILabel!
    @IBOutlet var lblUV: UILabel!
    @IBOutlet var lblHumidity: UILabel!
    @IBOutlet var lblTemp: UILabel!
    @IBOutlet var lblTempDefinition: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTempHighest: UILabel!
    @IBOutlet var lblTempLowest: UILabel!
    @IBOutlet var icTemp: UIImageView!
    @IBOutlet var emptyView: UIView!
    
    var generalModel: GeneralModel?
    var weatherInfoArray = [WeatherModel]()
    var todaysDateHumanRead: String?
    var todaysDate: String?
    let formatterHumanRead = DateFormatter()
    let formatter = DateFormatter()
    let date = Date()
    let degree = "\u{00B0}C"
    
    var dailyDetailArray = [WeatherModel]()
    var otherDaysDetailArray = [WeatherModel]()
    var selectedCitiesArray = [String]()
    var selectedCitiesNames = [String]()
    var nextDaysArr = [String]()
    var nextDaysNames = [String]()
    var todayDateStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.gray
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    
        emptyView.isHidden = false
        formatterHumanRead.dateFormat = "dd/MM/yyyy"
        formatter.dateFormat = "yyyy-MM-dd"
        self.todaysDateHumanRead = formatterHumanRead.string(from: date)
        self.todaysDate = formatter.string(from: date)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CustomIndicator.showActivityIndicator(uiView: self.view)
        getSelectedCities()
    }
    
    func getDayOfWeek() -> Int? {
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: self.todaysDate!) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    /*
     Kullanıcının daha önceden seçtiği şehirler olup olmadığı kontrol edilir.
     Varsa ona göre işlemler başlar
     */
    func getSelectedCities() {
        selectedCitiesArray.removeAll()
        self.selectedCitiesArray = userDefaults.stringArray(forKey: selectedCitiesUserDefaults) ?? ["empty"]
        if selectedCitiesArray.count > 0 {
            emptyView.isHidden = true
            for i in 0..<self.selectedCitiesArray.count {
                if selectedCitiesArray[0] != "empty" {
                    getInfos(selectedCityId: selectedCitiesArray[i])
                } else {
                    CustomIndicator.hideActivityIndicator(uiView: self.view)
                    emptyView.isHidden = false
                }
            }
        } else {
            CustomIndicator.hideActivityIndicator(uiView: self.view)
            emptyView.isHidden = false
        }
    }
    
    /*
     Veriler servisten çekilir ve model sınıfına entegre edilir.
     */
    func getInfos(selectedCityId: String) {
        self.weatherInfoArray.removeAll()
        self.selectedCitiesNames.removeAll()
        RestController().getWeathers(selectedCityId: selectedCityId) {
            result in
            if result.code == 200 {
                self.generalModel = GeneralModel(dict: result.response!)
                self.weatherInfoArray = self.generalModel!.list
                self.selectedCitiesNames.append((self.generalModel?.city!.name)!)
                self.selectedCityCollectionView.reloadData()
                self.getWeatherInfos()
            }
        }
    }
    
    func getWeatherInfos() {
        self.dailyDetailArray.removeAll()
        self.weatherInfoArray.forEach({ i in
            let dateArr = i.dt_txt?.components(separatedBy: " ")
            let serviceDate = dateArr?[0]
            if todaysDate == serviceDate {
                self.dailyDetailArray.append(i)
            } else {
                self.otherDaysDetailArray.append(i)
                let dateArr2 = i.dt_txt?.components(separatedBy: " ")
                let serviceDate2 = dateArr2?[0]
                if !nextDaysArr.contains(serviceDate2!) {
                    self.nextDaysArr.append(serviceDate2!)
                }
            }
        })
        if nextDaysArr.count > 0 {
            getDatesFromString()
        }
        getForecastWeather()
        getFirstDailyDetail()
        self.collectionView.reloadData()
        self.tableView.reloadData()
    }
    
    func getDatesFromString() {
        var date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        for i in 0..<nextDaysArr.count {
            date = dateFormatter.date(from: nextDaysArr[i])!
            getDatesName(date: date)
        }
    }
    
    func getDatesName(date: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "tr_TR")
        let dayInWeek = dateFormatter.string(from: date)
        self.nextDaysNames.append(dayInWeek)
    }
    
    func getForecastWeather() {
        let forecast = self.weatherInfoArray[0].main
        let weather = self.weatherInfoArray[0].weather[0]
        self.lblTemp.text = SessionParameters.shared.kelvinToCelcius(temp: (forecast?.temp)!)
        self.lblTempHighest.text = SessionParameters.shared.kelvinToCelcius(temp: (forecast?.temp_max)!)
        self.lblTempLowest.text = SessionParameters.shared.kelvinToCelcius(temp: (forecast?.temp_min)!)
        self.lblDate.text = self.todaysDateHumanRead
        self.lblTempDefinition.text = weather.description
        
        switch weather.main {
        case "Clear":
            icTemp.image = UIImage(named: "ic_sun")
            break
        case "Snow":
            icTemp.image = UIImage(named: "ic_snow")
            break
        case "Clouds":
            icTemp.image = UIImage(named: "ic_dark")
            break
        default:
            icTemp.image = UIImage(named: "ic_sun")
        }
    }
    
    func getFirstDailyDetail() {
        self.lblHumidity.text = "%" + (dailyDetailArray[0].main?.humidity)!.stringValue
        self.lblUV.text = (dailyDetailArray[0].main?.temp_kf)?.stringValue
        self.lblWind.text = (dailyDetailArray[0].wind?.speed)!.stringValue + " mhs/s"
        self.lblGorunurluk.text = (dailyDetailArray[0].visibility)!.stringValue + " m"
        
        CustomIndicator.hideActivityIndicator(uiView: self.view)
    }
}

extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyWeatherCell") as! WeeklyWeatherCell
        
        if self.otherDaysDetailArray.count > 0 {
            switch indexPath.row {
            case 0:
                cell.lblLowest.text = SessionParameters.shared.kelvinToCelcius(temp: otherDaysDetailArray[0].main!.temp_min!)
                cell.lblHighest.text = SessionParameters.shared.kelvinToCelcius(temp: otherDaysDetailArray[0].main!.temp_max!)
            case 1:
                cell.lblLowest.text = SessionParameters.shared.kelvinToCelcius(temp: otherDaysDetailArray[0].main!.temp_min!)
                cell.lblHighest.text = SessionParameters.shared.kelvinToCelcius(temp: otherDaysDetailArray[8].main!.temp_max!)
            case 2 :
                cell.lblLowest.text = SessionParameters.shared.kelvinToCelcius(temp: otherDaysDetailArray[0].main!.temp_min!)
                cell.lblHighest.text = SessionParameters.shared.kelvinToCelcius(temp: otherDaysDetailArray[16].main!.temp_max!)
            case 3 :
                cell.lblLowest.text = SessionParameters.shared.kelvinToCelcius(temp: otherDaysDetailArray[0].main!.temp_min!)
                cell.lblHighest.text = SessionParameters.shared.kelvinToCelcius(temp: otherDaysDetailArray[24].main!.temp_max!)
            case 4:
                cell.lblLowest.text = SessionParameters.shared.kelvinToCelcius(temp: otherDaysDetailArray[0].main!.temp_min!)
                cell.lblHighest.text = SessionParameters.shared.kelvinToCelcius(temp: otherDaysDetailArray[32].main!.temp_max!)
            default:
                cell.lblLowest.text = ""
                cell.lblHighest.text = ""
            }
            cell.lblWeekDay.text = nextDaysNames[indexPath.row]
        }
        
        return cell
    }
}

extension HomePageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.selectedCityCollectionView {
            return self.selectedCitiesNames.count
        } else {
            return self.dailyDetailArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayTimeCell", for: indexPath) as! DayTimeCell
            let dateArr = self.dailyDetailArray[indexPath.row].dt_txt?.components(separatedBy: " ")
            let time = dateArr?[1]
            let clockArr = time?.components(separatedBy: ":")
            let selectedClock = clockArr![0] + ":" + clockArr![1]
                
            cell.lblDayTime.text = selectedClock
            switch self.dailyDetailArray[indexPath.row].weather[0].main {
            case "Clear":
                cell.icDayTime.image = UIImage(named: "ic_sun")
                break
            case "Snow":
                cell.icDayTime.image = UIImage(named: "ic_snow")
                break
            case "Clouds":
                cell.icDayTime.image = UIImage(named: "ic_dark")
                break
            default:
                cell.icDayTime.image = UIImage(named: "ic_sun")
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedCityCell", for: indexPath) as! SelectedCityCell
            cell.lblSelectedCityName.text = selectedCitiesNames[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            let dailyDetail = self.dailyDetailArray[indexPath.row]
            self.lblHumidity.text = "%" + (dailyDetail.main?.humidity)!.stringValue
            self.lblUV.text = (dailyDetail.main?.temp_kf)?.stringValue
            self.lblWind.text = (dailyDetail.wind?.speed)!.stringValue + " mhs/s"
            self.lblGorunurluk.text = (dailyDetail.visibility)!.stringValue + " m"
        } else {
            
        }
    }
}

