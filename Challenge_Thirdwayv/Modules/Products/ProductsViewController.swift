//
//  ProductsViewController.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import UIKit

class ProductsViewController:  BaseViewController<ProductsViewModel> {
    
    //MARK: Vars
    var coordinator: ProductsCoordinator?
    
    
    //MARK: View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = ProductsViewModel()
        coordinator = .init()
        coordinator?.view = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
        
    }
    


    @IBAction func testBtn(_ sender: UIButton) {
        
        coordinator?.navigateProductDetail()
    }
    
}

