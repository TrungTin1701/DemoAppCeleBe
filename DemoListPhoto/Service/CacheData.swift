//
//  CacheData.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 23/10/2023.
//

import Foundation
import UIKit


struct Config {
    let countLimit : Int
    let memoryLimit: Int
    static let defaultconfig = Config(countLimit: 100, memoryLimit: 1024*1024*100)
    
}


var imageCache : NSCache<AnyObject, AnyObject> = {
    let cache = NSCache<AnyObject, AnyObject>()
    cache.totalCostLimit = Config.defaultconfig.memoryLimit
    return cache
}()



var decodedImageCache: NSCache<AnyObject, AnyObject> = {
    let cache = NSCache<AnyObject, AnyObject>()
    cache.totalCostLimit = Config.defaultconfig.memoryLimit
    return cache
}()

func imageLoading(for urlImage : URL) ->UIImage? {
    if let decodeImage = decodedImageCache.object(forKey: urlImage as AnyObject) as? UIImage {
        return decodeImage
    }
    if let image = imageCache.object(forKey: urlImage as AnyObject) as? UIImage {
        let decodedImage = image.decodedImage()
        decodedImageCache.setObject(image as AnyObject, forKey: urlImage as AnyObject)
        return decodedImage
    }
    return nil
}
extension UIImageView{
    
    
    
  
        func setImage(from urlImage: String) {
            if let image = decodedImageCache.object(forKey: urlImage as NSString) as? UIImage {
                self.image = image as UIImage
                debugPrint("Cache from data cache")
                return
            }

            guard let url = URL(string: urlImage) else {
                return
            }

            DispatchQueue.global().async {
                [weak self] in
                if let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
                    debugPrint("Image downloaded from server...")
                    let decodeImage = image.decodedImage()
                    DispatchQueue.main.async {
                        decodedImageCache.setObject(decodeImage, forKey: urlImage as NSString)
                        self?.image = decodeImage
                    }
                } else {
                    // Handle the case where imageData is nil (e.g., when the image couldn't be downloaded)
                    print("Failed to load or decode image from URL: \(url)")
                }
            }
        }
    }

extension UIImage{
    func decodedImage()->UIImage{
        guard let cgImage = cgImage else {
            return self
        }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let decodedImage = context?.makeImage() else  {return self}
        return UIImage(cgImage: decodedImage)
    }
}
