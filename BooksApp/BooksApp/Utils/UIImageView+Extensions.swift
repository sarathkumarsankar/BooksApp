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
    func setImageUsingCache(withUrl urlString: String?) {
        guard let urlString = urlString else {
            self.image = UIImage(named: "placeholder")
            return
        }
        /// check image already available in cache
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        self.image = nil
        /// update imageview with placeholder image
        self.image = UIImage(named: "placeholder")
        NetworkManager.shared.downloadImage(withUrl: urlString) { result in
            switch result {
            case .success(let result):
                guard let image = UIImage(data: result) else {
                    return
                }
                /// store image in cache
                imageCache.setObject(image, forKey: urlString as NSString)
                /// update imageview with downloaded image in main thread
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(_):
                break
            }
        }
    }
}

extension UIImageView {
    /// Use this function to set round corner image
    func setRoundCornerImage() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.white.cgColor
    }
}
