//
//  WeatherCollectionViewCell.swift
//  WeatherApi
//
//  Created by Emin Hayal on 23.01.2023.
//

import UIKit
import SnapKit

class WeatherCollectionViewCell: UICollectionViewCell {

    lazy var timeLabel: UILabel = {
       let timeLabel = UILabel()
        timeLabel.font = UIFont(name: timeLabel.font.fontName, size: 10)

        return timeLabel
    }()
    
    lazy var tempLabel: UILabel = {
       let tempLabel = UILabel()
        tempLabel.font = UIFont(name: timeLabel.font.fontName, size: 10)
        return tempLabel
    }()

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        layout()
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.50)
    }
    
    func configureData(tempData: Interval) {
        self.timeLabel.text = tempData.startTime
        if let temp = tempData.values?.temperature {
            let tempValue = Int(temp)
            self.tempLabel.text = "\(tempValue)"

        }
    }
    
    func layout() {
        
        //MARK: Time
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
        
        //MARK: Temp
        contentView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
//            make.edges.equalToSuperview().offset(10)
//            make.centerY.equalToSuperview()
            make.bottom.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension WeatherCollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nibName: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
