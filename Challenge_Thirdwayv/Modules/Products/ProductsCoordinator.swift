//
//  ProductsCoordinator.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation
import UIKit


class ProductsCoordinator: Coordinator, CoordinatorProtocol {
    typealias PresentingView = ProductsViewController

    weak var view: PresentingView?
    
    deinit {
        self.view = nil
    }
    
}


extension ProductsCoordinator {
    
    func navigateProductDetail(){
        guard let scene = UIViewController.instantiateInitialController(from: .productDetail) as? ProductDetailViewController else { return }
        view?.navigationController?.pushViewController(scene, animated: true)
        
    }
}