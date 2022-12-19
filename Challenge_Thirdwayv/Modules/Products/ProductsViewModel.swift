//
//  ProductsViewModel.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation
import Combine

protocol ProductsViewModelType {
    func requestProducts()
}

/// define all states of view.
enum ProductsViewModelState {
    case show([ProductsModel.Record])
    case error(String)
}

 
class ProductsViewModel: BaseViewModel {
    
    //MARK: Vars
    
    /// immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()

    private var cancellables: [AnyCancellable] = []
    private let stateDidUpdateSubject = PassthroughSubject<ProductsViewModelState, Never>()
    
    //MARK: Init
    init(useCase: ProductsUseCaseType) {
        super.init(useCase: useCase)
    }
    
}


extension ProductsViewModel: ProductsViewModelType {
    
    func requestProducts(){
        let viewModelUseCase = self.useCase as! ProductsUseCaseType
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        self.isLoading = true
        let request = Request.productsRequest()
        viewModelUseCase.request(request)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let products):
                    let productsRows: [ProductsModel.Record] = products.records ?? []
                    self.stateDidUpdateSubject.send(.show(productsRows))
                    
                case .failure(let error):
                    self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                }
            }.store(in: &cancellables)
        }
    
    
    }
