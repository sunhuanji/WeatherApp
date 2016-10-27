//
//  Weather.swift
//  WeatherApp
//
//  Created by Sun Huanji on 2016/10/25.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Weather{
    var _cityName:String!
    var _date:String!
    var _weatherType:String!
    var _currentTemp:Double!
    
    var date:String{
        if _date == nil{
          _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today,\(currentDate)"
        
        return _date
    }
    
    var cityName:String{
        if _cityName == nil{
         _cityName = ""
        }
        return _cityName
    }
    
    var weatherType:String{
        if _weatherType == nil{
          _weatherType = ""
        }
        return _weatherType
    }
    var currentTemp:Double{
        if _currentTemp == nil{
         _currentTemp = 0.0
        }
        return _currentTemp
    }

//    func downloadWeatherDetails(completed:@escaping DownloadComplete){
//        Alamofire.request(CURRENT_WEATHER_URL).responseJSON{ response in
//            let result = response.result
//            if let dict = result.value as? Dictionary<String, AnyObject>{
//                if let name = dict["name"] as? String{
//                    self._cityName = name.capitalized
//                }
//                
//                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
//                    if let main = weather[0]["main"] as? String{
//                        self._weatherType = main
//                    }
//                }
//                
//                if let main = dict["main"] as? Dictionary<String, AnyObject>{
//                    if let currentTemperature = main["temp"] as? Double{
//                        let SheShiTemp = currentTemperature - 273.15
//                        self._currentTemp = SheShiTemp
//                    }
//                }
//                
//            }
//            completed()
//        }
//    }
//    if let values = response.result.value{
//        let json = JSON(values)
//        let temp1 = json["main"]["temp"].double!
//        let temp2 = temp1 - 273.15
//        self.temp.text = String(format: "%.1f", temp2) + "℃"
//        self.weatherTitle.text = json["weather"][0]["main"].string
//        let iconName = json["weather"][0]["icon"].string
//        let icon = "http://openweathermap.org/img/w/" + iconName! + ".png"
//        let iconUrl = NSURL(string: icon)
//        self.weatherIcon.af_setImageWithURL(iconUrl!)
//    }
//    Alamofire.request(.GET, "https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=100&q=http://rss.rssad.jp/rss/nikkansports/rss/baseball/professional/atom/marines.xml?rss").responseJSON { response in
//    if let values = response.result.value {
//    JSON(values)["responseData"]["feed"]["entries"].forEach {i,value in
//    self.entries.append(Entry(
//    publishedDate: value["publishedDate"].string!,
//    title: value["title"].string!,
//    content: value["content"].string!,
//    link: value["link"].string!
//    
//    ))
//    }
//    print(values)
//    self.tableView.reloadData()
//    }
//    }
    
    func downloadWeatherDetails(completed:@escaping DownloadComplete){
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            if let values = response.result.value{
                let json = JSON(values)
                let name = json["name"].string
                let weather = json["weather"][0]["main"].string
                let temp = json["main"]["temp"].double
                let SheShiTemp = temp! - 273.15
                self._cityName = name
                self._weatherType = weather
                self._currentTemp = SheShiTemp
            }
            completed()
        }
    }
    
}
