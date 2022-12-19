//
//  PhotoCacheManager.swift
//  Challenge_Thirdwayv
//
//  Created by Esraa Eid on 19/12/2022.
//

import Foundation
import UIKit

final class PhotoCacheManager {
    static let shared = PhotoCacheManager()
    
    private init() { }
    
    var photoCache: NSCache<NSString, UIImage> = {
       var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return cache
    }()
    
    func add(key: String, value: UIImage) {
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }
    
}
