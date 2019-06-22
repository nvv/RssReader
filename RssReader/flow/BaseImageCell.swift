//
//  BaseImageCell.swift
//  RssReader
//
//  Created by Vlad Namashko on 6/15/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class BaseImageCell : BaseNewsCell {

    internal func loadThumbnail(thumbnailUrl: String, thumbnail: UIImageView, width: CGFloat, height: CGFloat) {
        DispatchQueue.global().async { [weak self] in
                let url = URL(string: thumbnailUrl)
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            thumbnail.contentMode = .scaleAspectFit
                            let img = self?.resizeCropCenter(image: image, targetSize: CGSize(width: width, height: height), resizeAdjust: .width)
                            thumbnail.image = img
                            self?.onThumbnailLoaded()
                    }
                }
            }
        }
    }
    
    internal func onThumbnailLoaded() {
    }
    
    internal func resizeCropCenter(image: UIImage, targetSize: CGSize, resizeAdjust: ResizeAdjustEnum) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var imgWidth: CGFloat
        var imgHeight: CGFloat
        if (resizeAdjust == .width) {
            imgWidth = size.width * widthRatio
            imgHeight = size.height * widthRatio
            
            if (imgHeight < targetSize.height) {
                imgWidth *= targetSize.height / imgHeight
                imgHeight = targetSize.height
            }
        } else {
            imgWidth = size.width * heightRatio
            imgHeight = size.height * heightRatio
            
        }
        
        var newSize: CGSize
        //        if widthRatio > heightRatio {
        //            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        //        } else {
        newSize = CGSize(width: imgWidth,  height: imgHeight)
        //        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let targetWidth = Int(targetSize.width)
        let targetHeight = Int(targetSize.height)
        
        if let newImage = newImage {
            return cropImage(image: newImage, cropRect: CGRect(
                x: Int(newImage.size.width / 2) - targetWidth,
                y: Int(newImage.size.height / 2) - targetHeight,
                width: targetWidth,
                height: targetHeight))
        }
        
        return newImage!
    }
    
    internal func resize(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    internal func cropImage(image: UIImage , cropRect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(cropRect.size, false, 0);
        let context = UIGraphicsGetCurrentContext();
        
        context?.translateBy(x: 0.0, y: image.size.height);
        context?.scaleBy(x: 1.0, y: -1.0);
        context?.draw(image.cgImage!, in: CGRect(x:0, y:0, width:image.size.width, height:image.size.height), byTiling: false);
        context?.clip(to: [cropRect]);
        
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return croppedImage!;
    }
}

enum ResizeAdjustEnum {
    case width
    case height
}
