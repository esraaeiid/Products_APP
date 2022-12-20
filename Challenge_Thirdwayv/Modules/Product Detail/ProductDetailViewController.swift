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
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    private var imageLoader: ImageLoader?
    var product: ProductsModel.Record?
    
    
    //MARK: View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Product"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = ProductDetailViewModel()
        coordinator = .init()
        coordinator?.view = self
        
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator = nil
        viewModel = nil
        
    }
    
    override func bind() {
        super.bind()
        
        ///Descripton
        self.productDescriptionLabel.text = product?.productDescription
        
        ///Image
        if let url = product?.image?.url, let productID = product?.id {
            self.imageLoader = ImageLoader(url: url,
                                           productID: String(productID))
        }
        
        guard self.imageLoader != nil else {
            return
        }
        
        self.imageLoader?.$image.sink { [weak self] img in
            guard let self = self else { return }
            
            if img != nil {
                self.productImageView.image = img
                self.imageLoader = nil
            }
            
        }.store(in: &self.cancellable)
            
    }
    

 
}
