//
//  NetworkResponse.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var result: [Wrapped]
}
