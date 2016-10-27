//
//  Forecast.swift
//  WeatherApp
//
//  Created by Sun Huanji on 2016/10/27.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit
import Alamofire

class ForeCast {
    var _date:String!
    var _weatherType:String!
    var _highTemp:Double!
    var _lowTemp:Double!
    
    var date:String{
        if _date == nil{
         _date = ""
        }
        return _date
    }
    
    var weatherType:String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp:Double{
        if _highTemp == nil{
            _highTemp = 0.0
        }
        return _highTemp
    }
    
    var lowTemp:Double{
        if _lowTemp == nil{
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    init(weatherDict:Dictionary<String, AnyObject>){
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
            if let min = temp["min"] as? Double{
             let SheShiMin = min - 273.15
                self._lowTemp = SheShiMin
            }
            if let max = temp["max"] as? Double{
             let SheShiMax = max - 273.15
                self._highTemp = SheShiMax
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
              self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
          let unixConverteDate = Date(timeIntervalSince1970: date)
          let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConverteDate.dayOfTheWeek()
        }
    }
}

extension Date{
    func dayOfTheWeek() -> String{
      let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
