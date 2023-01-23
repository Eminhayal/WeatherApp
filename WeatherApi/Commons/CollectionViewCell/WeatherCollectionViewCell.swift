//
//  WeatherCollectionViewCell.swift
//  WeatherApi
//
//  Created by Emin Hayal on 23.01.2023.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    var tempData: [Interval] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .cyan
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
