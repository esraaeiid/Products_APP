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

    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }

    func store(image: UIImage,
                        forKey key: String) {
        if let pngRepresentation = image.pngData() {
         
                if let filePath = filePath(forKey: key) {
                    do  {
                        try pngRepresentation.write(to: filePath,
                                                    options: .atomic)
                    } catch let err {
                        print("Saving file resulted in error: ", err)
                    }
                }
        }
    }
    
     func retrieveImage(forKey key: String) -> UIImage? {

        if let filePath = self.filePath(forKey: key),
           let fileData = FileManager.default.contents(atPath: filePath.path),
           let image = UIImage(data: fileData) {
            return image
        }
    
        return nil
    }

    
}
