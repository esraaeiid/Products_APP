//
//  Request.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation

import Combine
import Foundation

struct Request {
    static let baseURL = "https://api.npoint.io/4b61856ec554b0bfe5ed"
    
    let url: URL
    var request: URLRequest? {
        return URLRequest(url: url)
    }

    init(url: URL) {
        self.url = url
    }
}





extension Request {
    static func productsRequest() -> Request {
        let url = URL(string: self.baseURL)!
        return Request(url: url)
    }
}
