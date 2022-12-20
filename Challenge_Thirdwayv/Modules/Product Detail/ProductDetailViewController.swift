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
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    
    private var imageLoader: ImageLoader?
    var product: ProductsModel.Record?
    var productImg: UIImage?
    
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
        updateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator = nil
        viewModel = nil
        productImageView.image = nil
    }
    
    override func bind() {
        super.bind()
    }
    
    
    func updateView(){
        ///Product Descripton
        self.productDescriptionLabel.text = product?.productDescription
        
        //Product Image
        self.productImageView.image = self.productImg
        self.imageHeightConstraint.constant = CGFloat(self.product?.image?.height ?? 100)
        self.imageWidthConstraint.constant = CGFloat(self.product?.image?.width ?? 100)
        
        print(("Width \(self.imageWidthConstraint.constant)"))
        print(("Height \( self.imageHeightConstraint.constant )"))
    }

 
}
