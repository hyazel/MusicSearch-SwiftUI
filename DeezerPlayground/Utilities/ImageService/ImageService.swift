//
//  ImageService.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 30/04/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import UIKit

class ImageService {
    let cache = NSCache<NSString, UIImage>()

    init() {
        // I put default values
        cache.countLimit = 20
        cache.totalCostLimit = 20 * 1024 * 1024 // Max 20 MB
    }

    func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
            var downloadedImage:UIImage?

            if let data = data {
                downloadedImage = UIImage(data: data)
            }

            if downloadedImage != nil {
                self.cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }

            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }

        dataTask.resume()
    }

    func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            downloadImage(withURL: url, completion: completion)
        }
    }
}
