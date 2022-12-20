//
//  ProductsViewController.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import UIKit
import Combine

class ProductsViewController:  BaseViewController<ProductsViewModel> {
    
    //MARK: Vars
    var coordinator: ProductsCoordinator?
        
    @IBOutlet weak var productsCollectionView: UICollectionView! {
        didSet {
            productsCollectionView.delegate = self
            productsCollectionView.dataSource = self
            productsCollectionView.showsVerticalScrollIndicator = false
            productsCollectionView.showsHorizontalScrollIndicator = false
            productsCollectionView.backgroundColor = .clear
            productsCollectionView.register(nibWithCellClass: ProductCell.self)
            if let layout = productsCollectionView?.collectionViewLayout as? PinterestLayout {
                layout.delegate = self
            }
        }
    }
    
    //MARK: View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Products list"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = ProductsViewModel(useCase: ProductsUseCase())
        coordinator = .init()
        coordinator?.view = self
        
        viewModel?.requestProducts()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
        
    }
    
    
    
    override func bind() {
        super.bind()
        viewModel?.$isLoading.sink{ isLoading in
            print("...\(isLoading)...")
            if isLoading {
                LoadingView.show()
            } else {
                LoadingView.hide()
            }
        }.store(in: &cancellable)
       
        viewModel?.stateDidUpdate.sink{ [weak self] state in
            guard let self = self else { return }
            self.render(state)
        }.store(in: &cancellable)
        
        
        viewModel?.$products.sink{  [weak self] products in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
           
        }.store(in: &cancellable)
    }
    
    
    
    private func render(_ state: ProductsViewModelState){
        switch state {
        case .show(let isFetched):
            print("products 😍", isFetched)
            
        case .error(let errorMessage):
            print("error 😭", errorMessage)
        }
    }
 
    
}



// MARK: - ...  UICollectionViewDelegateFlowLayout & UICollectionViewDataSource

extension ProductsViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getProductCount() ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if let product = self.viewModel?.fetchProduct(index: indexPath.row) {
            coordinator?.navigateProductDetail(product)
        }
    }
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: ProductCell.self, for: indexPath)
    
        if let product = self.viewModel?.fetchProduct(index: indexPath.row) {
            cell.bind(product)
        }
        return cell
  
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (viewModel?.getProductCount() ?? 0) - 1,
            viewModel?.hasNext ?? false {
                viewModel?.requestProducts()
            }
    }
    


    
}

//MARK: - PinterestLayoutDelegate

extension ProductsViewController: PinterestLayoutDelegate {
    
  func collectionView(
    _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        if let product = self.viewModel?.fetchProduct(index: indexPath.row),
           let height = product.image?.height  {
            return CGFloat(height)
        }
        
        return 200
    }
}
