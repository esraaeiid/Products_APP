//
//  ImageLoader.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 19/12/2022.
//

import Foundation
import UIKit
import Combine

final class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    let manager: PhotoCacheManager = PhotoCacheManager.shared
    let urlString: String
    let productID: String
    
    init(url: String, productID: String) {
        self.urlString = url
        self.productID = productID
        getImage()
    }
    
    private func getImage() {
        if let savedImage = manager.get(key: productID) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnData in
                self?.image = returnData
            }
            .store(in: &cancellables)
    }
}
