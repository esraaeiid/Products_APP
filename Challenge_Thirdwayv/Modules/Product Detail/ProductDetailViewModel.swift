//
//  ProductDetailViewModel.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation


class ProductDetailViewModel: BaseViewModel {
    
    //MARK: Vars
//    @Published var product: ProductsModel.Record?
    
    //MARK: Init
    init(){
        let useCase = ProductDetailUseCase()
        super.init(useCase: useCase)
    }
}
