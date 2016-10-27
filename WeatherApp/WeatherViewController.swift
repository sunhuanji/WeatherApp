//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sun Huanji on 2016/10/25.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var dateLebal: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var currentWeather = Weather()
    var forcasts = [ForeCast]()
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation() //?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        currentWeather = Weather()
        // locationAuthStatus()
        //forecast = ForeCast()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    @IBOutlet weak var tableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell{
          let forecast = forcasts[indexPath.row]
          cell.configureCell(forecast: forecast)
            
            return cell
        }else{
            return WeatherTableViewCell()
        }
    }

    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
          currentLocation = locationManager.location!
          Location.shareInstance.latitude = currentLocation.coordinate.latitude
          Location.shareInstance.longitude = currentLocation.coordinate.longitude
          print(Location.shareInstance.latitude, Location.shareInstance.longitude)
            currentWeather.downloadWeatherDetails {
                print("bbbbbbb")
                print(CURRENT_WEATHER_URL)
                self.downloadForecastData {
                    print("ccccccc")
                    self.upadateMainUI()
                }
            }
            
        }else{
          locationManager.requestWhenInUseAuthorization()
          locationAuthStatus()
        }
    }
    
    func upadateMainUI(){
        dateLebal.text = currentWeather.date
        print(currentWeather.date)
        currentTempLabel.text = String(format: "%.1f", currentWeather.currentTemp) + "℃"
        print(currentWeather.currentTemp)
        currentWeatherTypeLabel.text = currentWeather.weatherType
        print(currentWeather.weatherType)
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    func downloadForecastData(completed:@escaping DownloadComplete){
        //download data for tableView
        Alamofire.request(FORECAST_URL).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    for obj in list {
                        let forecast = ForeCast(weatherDict: obj)
                        self.forcasts.append(forecast)
                    }
                    self.forcasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
        
    }

}

