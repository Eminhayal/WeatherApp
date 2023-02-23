//
//  Storyboard+Extension.swift
//  WeatherApi
//
//  Created by Emin Hayal on 2.01.2023.
//

//import UIKit
//
//enum StoryboardType: String {
//    case home = "Main"
//    case detail = "Detail"
//}
//
//protocol StoryboardInstantiate {
//    static var storyboardType: StoryboardType { get }
//    static var storyboardIdentifier: String? { get }
//    static var bundle: Bundle? { get }
//}
//
//extension StoryboardInstantiate {
//    static var storyboardIdentifier: String? { return String(describing: self) }
//    static var bundle: Bundle? { return nil }
//
//    static func instantiate() -> Self {
//        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: bundle)
//        if let strongIdentifier = storyboardIdentifier {
//            return (storyboard.instantiateViewController(withIdentifier: strongIdentifier) as? Self)!
//        }
//        return (storyboard.instantiateInitialViewController() as? Self)!
//    }
//}

import UIKit

public enum StoryboardNames: String {
    case main = "Main"
    case detail = "Detail"
    
}

protocol StoryboardSettings {
    var storyboardName: StoryboardNames { get set }
}

extension UIViewController: StoryboardSettings {
    var storyboardName: StoryboardNames {
        get {
            return storyboardName
        }
        set {
            storyboardName = newValue
        }
    }
    
}

public extension UIViewController {
    /// SwifterSwift: Instantiate UIViewController from storyboard.
    ///
    /// - Parameters:
    ///   - storyboard: Name of the storyboard where the UIViewController is located.
    ///   - bundle: Bundle in which storyboard is located.
    ///   - identifier: UIViewController's storyboard identifier.
    /// - Returns: Custom UIViewController instantiated from storyboard.
    
    class func instantiate(storyboard: StoryboardNames = StoryboardNames.main, bundle: Bundle? = nil, identifier: String? = nil) -> Self {
        let viewControllerIdentifier = identifier ?? String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: viewControllerIdentifier) as? Self else {
            preconditionFailure(
                "Unable to instantiate view controller with identifier \(viewControllerIdentifier) as type \(type(of: self))")
        }
        return viewController
    }
}
public extension UIViewController {
    
}
