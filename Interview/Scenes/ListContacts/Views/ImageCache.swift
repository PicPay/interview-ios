//
//  ImageCache.swift
//  Interview
//
//  Created by Jarede Lima on 18/03/24.
//  Copyright © 2024 PicPay. All rights reserved.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSURL, UIImage>()
    
    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func cache(image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
