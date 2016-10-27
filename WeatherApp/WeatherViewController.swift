//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sun Huanji on 2016/10/25.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var dateLebal: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!

    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var currentWeather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(CURRENT_WEATHER_URL)
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = Weather()
        currentWeather.downloadWeatherDetails {
                self.upadateMainUI()
        }


        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var tableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        return cell
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



}

