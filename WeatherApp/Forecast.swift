//
//  Forecast.swift
//  WeatherApp
//
//  Created by Sun Huanji on 2016/10/27.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
    
    init(weatherDict:JSON){
        let min = weatherDict["temp"]["min"].double
        let SheShiMin = min! - 273.15
        let max = weatherDict["temp"]["max"].double
        let SheShiMax = max! - 273.15
        let main = weatherDict["weather"][0]["main"].string
        let date = weatherDict["dt"].double
        self._lowTemp = SheShiMin
        self._highTemp = SheShiMax
        self._weatherType = main
        let unixConverteDate = Date(timeIntervalSince1970: date!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeStyle = .none
        self._date = unixConverteDate.dayOfTheWeek()
    }
}

extension Date{
    func dayOfTheWeek() -> String{
      let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
