//
//  ProductDetailViewModel.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation


class ProductDetailViewModel: BaseViewModel {
    
    init(){
        let useCase = ProductDetailUseCase()
        super.init(useCase: useCase)
    }
}
