//
//  ProductsModel.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation


// MARK: - Entity
struct ProductsModel: Codable {
    
    let records: [Record]?
    
    
    // MARK: - Record
    struct Record: Codable {
        let id: Int?
        let productDescription: String?
        let image: Image?
        let price: Int?
    }
    
    // MARK: - Image
    struct Image: Codable {
        let width, height: Int?
        let url: String?
        let data: String?
    }
    
    
}
