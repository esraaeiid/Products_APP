//
//  ProductsUseCase.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation
import Combine


protocol ProductsUseCaseType: UseCase {
    func request(_ request: Request) -> AnyPublisher<Result<ProductsModel, APIError>, Never>
}


class ProductsUseCase: UseCase {
    // MARK: -  Vars
    var apiClient: APIClientType

    // MARK: - Init
    init(apiClient: APIClientType = APIClient()) {
        self.apiClient = apiClient
    }

}



// MARK: - Extension
extension ProductsUseCase: ProductsUseCaseType {

    func request(_ request: Request) -> AnyPublisher<Result<ProductsModel, APIError>, Never> {
        return apiClient
            .execute(request)
    }
}
