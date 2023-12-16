//
//  ImageHelper.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation
import SwiftUI

class ImageHelper {
    private static var cache = NSCache<NSString, UIImage>()
    
    static func exitsImage(urlString: String) -> UIImage? {
        guard let image = cache.object(forKey: urlString as NSString) else {
            return nil
        }
        
        return image
    }
    
    @MainActor static func saveImage(urlString: String, image: Image) {
        guard let uiImage = ImageRenderer(content: image).uiImage else {
            return
        }
        self.cache.setObject(uiImage, forKey: urlString as NSString)
    }
}
