//
//  Location.swift
//  WeatherApp
//
//  Created by Sun Huanji on 2016/10/27.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import CoreLocation

class Location {
   static var shareInstance = Location()
    private init(){}
    
    var latitude:Double!
    var longitude:Double!
}
