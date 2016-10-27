//
//  Constents.swift
//  WeatherApp
//
//  Created by Sun Huanji on 2016/10/25.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import Foundation
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let APP_KEY = "dadca499d4351f1454d8350592c62641"
let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)-36\(LONGITUDE)123\(APP_ID)\(APP_KEY)"

typealias DownloadComplete = () -> ()
