//
//  ProductsViewController.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import UIKit
import Combine

class ProductsViewController:  BaseViewController<ProductsViewModel> {
    
    //MARK: Vars
    var coordinator: ProductsCoordinator?
    var imageLoader: ImageLoader?
    
    @IBOutlet weak var testImgView: UIImageView!
    
    
    //MARK: View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = ProductsViewModel(useCase: ProductsUseCase())
        coordinator = .init()
        coordinator?.view = self
        
        viewModel?.requestProducts()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
        
    }
    
    
    override func bind() {
        super.bind()
        viewModel?.$isLoading.sink{ isLoading in
            print("...\(isLoading)...")
        }.store(in: &cancellable)
       
        viewModel?.stateDidUpdate.sink{ [weak self] state in
            guard let self = self else { return }
            self.render(state)
        }.store(in: &cancellable)
        
        
    }
    
    private func render(_ state: ProductsViewModelState){
        switch state {
        case .show(let products):
            print("products 😍", products)
            self.testImage(product: products.first!)
            
        case .error(let errorMessage):
            print("error 😭", errorMessage)
        }
    }
    
    func testImage(product: ProductsModel.Record){
        
        if let url = product.image?.url, let productID = product.id {
         imageLoader = ImageLoader(url: url,
                                      productID: String(productID))
        }

        guard imageLoader != nil else {
            return
        }



        imageLoader?.$image.sink { [weak self] img in
            guard let self = self else { return }

            if img != nil {
                self.testImgView.image = img
                self.imageLoader = nil
            }

        }.store(in: &cancellable)
        
    }
    


    @IBAction func testBtn(_ sender: UIButton) {
        
        coordinator?.navigateProductDetail()
    }
    
}

