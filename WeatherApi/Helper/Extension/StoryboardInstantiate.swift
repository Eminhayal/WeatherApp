//
//  Storyboard+Extension.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

import UIKit

public enum StoryboardNames: String {
    case main = "Main"
    case detail = "Detail"
}

protocol StoryboardSettings {
    static func instantiate(name: StoryboardNames) -> Self
}

extension StoryboardSettings where Self: UIViewController {
    static func instantiate(name: StoryboardNames) -> Self {
        let strongId = String(describing: self)
        let storyboard = UIStoryboard(name: name.rawValue, bundle: Bundle.main)
        
        return (storyboard.instantiateViewController(withIdentifier: strongId) as? Self)!
    }
}
