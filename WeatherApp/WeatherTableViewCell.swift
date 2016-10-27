//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Sun Huanji on 2016/10/27.
//  Copyright © 2016年 Sun Huanji. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var hightemp: UILabel!
    @IBOutlet weak var lowtemp: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    func configureCell(forecast:ForeCast){
      lowtemp.text = String(format: "%.1f", forecast.lowTemp) + "℃"
      hightemp.text = String(format: "%.1f", forecast.highTemp) + "℃"
      weatherTypeLabel.text = forecast.weatherType
      dayLabel.text = forecast.date
      weatherIcon.image = UIImage(named: forecast.weatherType)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
