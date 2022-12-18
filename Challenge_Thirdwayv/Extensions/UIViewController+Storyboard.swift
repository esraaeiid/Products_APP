//
//  UIViewController+Storyboard.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation
import UIKit


protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable where Self: UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: Identifiable {}

enum Storyboard: String {
    case products = "ProductsStoryboard"
    case productDetail = "ProductDetailStoryboard"
}

extension UIViewController {
    static func instantiateController<T: UIViewController>(from storyboard: Storyboard) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: self.identifier) as? T else {
            fatalError("Storyboard ID is not same as \(self.identifier)")
        }
        return viewController
    }
    
    static func instantiateInitialController<T: UIViewController>(from storyboardName: Storyboard) -> T {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? T else {
            fatalError("Couldn't find UIVIEWController with name \(storyboardName.rawValue)")
        }
        return viewController
    }

}
