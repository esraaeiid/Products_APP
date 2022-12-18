//
//  Coordinator.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation
import UIKit


class Coordinator: NSObject {
    
    
    func restart(){
        let scene = UIViewController.instantiateInitialController(from: .products)
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.window?.rootViewController = scene
    }
    
    func networkFail(){
        
    }
    
    func cachingFail(){
        
    }
}



//MARK: - Coordinator Singletone
extension Coordinator {
    struct Static {
        static var instance: Coordinator?
    }
    
    class var instance: Coordinator {
        if Static.instance == nil {
            Static.instance = Coordinator()
        }
        return Static.instance!
    }
    
}
