//
//  UIImageView+Extensions.swift
//  LloydsTestProject
//
//  Created by SarathKumar S on 28/09/22.
//

import Foundation
import UIKit

/// variable for caching downlaoded images
fileprivate let imageCache = NSCache<NSString, AnyObject>()

/// UIImageview extension
/// Use this extension to download the image from url and store it in cache
extension UIImageView {
    
    /// To downlad image with image url
    ///  - Parameter urlString: image url string
    func loadImageUsingCache(withUrl urlString: String) {
        
        /// check image already available in cache
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        self.image = nil
        /// update imageview with placeholder image
        self.image = UIImage(named: "placeholder")
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                /// store image in cache
                imageCache.setObject(image, forKey: urlString as NSString)
                /// update imageview with downloaded image in main thread
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }).resume()
    }
}
