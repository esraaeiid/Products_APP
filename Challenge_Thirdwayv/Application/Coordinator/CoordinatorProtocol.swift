//
//  CoordinatorProtocol.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 18/12/2022.
//

import Foundation

protocol CoordinatorProtocol {
    
    associatedtype PresentingView
    var view: PresentingView? { get set }
}
