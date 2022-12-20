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
    case show(Bool)
    case error(String)
}

 
class ProductsViewModel: BaseViewModel {
    
    //MARK: Vars
    /// immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()

    private var cancellables: [AnyCancellable] = []
    private let stateDidUpdateSubject = PassthroughSubject<ProductsViewModelState, Never>()
    @Published var products: [ProductsModel.Record] = []
    var store = ProductStore()

    public private(set) var hasNext: Bool = false
    
    //MARK: Init
    init(useCase: ProductsUseCaseType) {
        super.init(useCase: useCase)
    }
    
}

//MARK: - Request

extension ProductsViewModel: ProductsViewModelType {
    
    func requestProducts(){
        guard let viewModelUseCase = self.useCase as? ProductsUseCaseType else { return }
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
            
                    self.products += products.records  ?? []
                    print("count⏺", self.products.count)
                    self.cacheProducts(products: self.products)
                    self.stateDidUpdateSubject.send(.show(true))
                    
                    let totalRecords = Constants.totalRecords // added limitation for disk memory safety
                    self.hasNext = totalRecords == self.products.count ? false : true
                    print("hasNext❓", self.hasNext)
                    
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
            print("Hello I'm going to save! 🫡")
            ProductStore.save(fetchedProducts: products) { result in
                if case .failure(let error) = result {
                    fatalError(error.localizedDescription)
                } else if case .success(let count) = result {
                    print("products at store count! 🕵🏼‍♀️", count)
                }
            }
        }
    }
    
    
    //MARK: fetching prodcuts
    func fetchProduct(index: Int) -> ProductsModel.Record? {
        if products.indices.contains(index) {
            return products[index]
        }
        return nil
    }
   
    
    func getProductCount() -> Int {
        return products.count
    }
    

}
