//
//  ProductDetailCoordinator.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation


class ProductDetailCoordinator: Coordinator, CoordinatorProtocol {
    typealias PresentingView = ProductDetailViewController
    
    weak var view: PresentingView?
    
    deinit {
        self.view = nil
    }
    
    
}


extension ProductDetailCoordinator {
    
}
