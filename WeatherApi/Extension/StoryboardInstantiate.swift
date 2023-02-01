//
//  Storyboard+Extension.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

import UIKit

enum StoryboardType: String {
    case home = "Main"
    case detail = "Detail"
}

protocol StoryboardInstantiate {
    static var storyboardType: StoryboardType { get }
    static var storyboardIdentifier: String? { get }
    static var bundle: Bundle? { get }
}

extension StoryboardInstantiate {
    static var storyboardIdentifier: String? { return String(describing: self) }
    static var bundle: Bundle? { return nil }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: bundle)
        if let strongIdentifier = storyboardIdentifier {
            return (storyboard.instantiateViewController(withIdentifier: strongIdentifier) as? Self)!
        }
        return (storyboard.instantiateInitialViewController() as? Self)!
    }
}
