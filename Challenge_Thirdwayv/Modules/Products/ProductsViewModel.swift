//
//  ProductsViewModel.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation

 
class ProductsViewModel: BaseViewModel {
    
    init() {
//        let repository = CarTypeRepositoryIMPL(remote: CarTypeRemoteService())
//
//        let carTypeUseCase = CarTypeUseCase()
//        carTypeUseCase.fetchManufacturer = FetchManufacturerUseCase(repository: repository, pageNumber: pageNumber)
//
//        super.init(useCase: carTypeUseCase)
        let useCase = ProductsUseCase()
        super.init(useCase: useCase)
    }
    
}
