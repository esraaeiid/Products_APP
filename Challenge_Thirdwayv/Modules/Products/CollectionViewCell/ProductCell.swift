//
//  ProductCell.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 20/12/2022.
//

import UIKit
import Combine

class ProductCell: UICollectionViewCell {

    //MARK: Vars
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

     var imageLoader: ImageLoader?
    var cancellable: [AnyCancellable] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func bind(_ product: ProductsModel.Record){
        
        ///Price
        self.priceLabel.text = "\(product.price ?? 0)"
        
        ///Descripton
        self.descriptionLabel.text = product.productDescription
        
        ///Image
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
                self.productImageView.image = img
                self.imageLoader = nil
            }

        }.store(in: &cancellable)
        
    }
}
