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
    var products: [ProductsModel.Record] = []
    var store = ProductStore()

    
    //MARK: Init
    init(useCase: ProductsUseCaseType) {
        super.init(useCase: useCase)
    }
    
}

//MARK: - Request

extension ProductsViewModel: ProductsViewModelType {
    
    func requestProducts(){
        let viewModelUseCase = self.useCase as! ProductsUseCaseType
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        self.isLoading = true
        self.loadCachedProducts()
        
        let request = Request.productsRequest()
        viewModelUseCase.request(request)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let products):
                    let productsRows: [ProductsModel.Record] = products.records ?? []
                    self.products = productsRows
                    self.cacheProducts(products: productsRows)
                    self.stateDidUpdateSubject.send(.show(productsRows))
                    
                case .failure(let error):
                    self.syncCachedProducts()
                    self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                }
            }.store(in: &cancellables)
    }
    
    
}


//MARK: - Functions

extension ProductsViewModel {
  
    //MARK: caching
    func syncCachedProducts(){
        store.$products.sink{ savedProducts in
            self.products = savedProducts
        }.store(in: &cancellables)
    }
    
    func loadCachedProducts(){
        ProductStore.load { result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let products):
                self.store.products = products
            }
        }
    }
    
    func cacheProducts(products: [ProductsModel.Record]){
        if products != store.products {
            ProductStore.save(fetchedProducts: products) { result in
                if case .failure(let error) = result {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    
    //MARK: fetching prodcuts
    func fetchProducts(){
        
    }
    
    
    func fetchProduct(){
        
    }
    
    
}
