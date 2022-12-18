//
//  ProductDetailViewController.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import UIKit

class ProductDetailViewController: BaseViewController<ProductDetailViewModel> {

    //MARK: Vars
    var coordinator: ProductDetailCoordinator?
//    var viewModel: ProductDetailViewModel?
    
    
    //MARK: View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = ProductDetailViewModel()
        coordinator = .init()
        coordinator?.view = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator = nil
        viewModel = nil
        
    }
    

 
}
