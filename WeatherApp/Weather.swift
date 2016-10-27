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

    func downloadWeatherDetails(completed:@escaping DownloadComplete){
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    if let currentTemperature = main["temp"] as? Double{
                        let SheShiTemp = currentTemperature - 273.15
                        self._currentTemp = SheShiTemp
                    }
                }
                
            }
            completed()
        }
    }
    
}
