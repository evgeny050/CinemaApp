//
//  ImageCacheManager.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 20.03.2024.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
