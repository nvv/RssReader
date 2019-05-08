//
//  NewsTableViewCell.swift
//  RssReader
//
//  Created by Vlad Namashko on 4/21/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UITextView!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
//        newsDescription.textContainer.maximumNumberOfLines = 3
//        newsDescription.textContainer.lineBreakMode = .byTruncatingTail
//        newsDescription.isEditable = false
//        newsDescription.isScrollEnabled = false
//
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsDescription.textContainer.maximumNumberOfLines = 3
        newsDescription.textContainer.lineBreakMode = .byTruncatingTail
        newsDescription.isEditable = false
        newsDescription.isScrollEnabled = false
        
        newsTitle.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(_ newsItem: RssFeed.Item) {
        newsTitle.text = newsItem.title
        newsDescription.text = newsItem.description
        
        DispatchQueue.global().async { [weak self] in
            let url = URL(string: newsItem.thumbnail.url)
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.thumbnail.contentMode = .scaleAspectFit
                        let img = self?.resizeHeightCrop(image: image, targetSize: CGSize(width: 86, height: 100))
//
//                        let targetWidth = 86
//                        let targetHeight = 100
//
//                        let img = self?.cropImage(image: image, cropRect: CGRect(
//                            x: Int(image.size.width / 2) - targetWidth,
//                            y: Int(image.size.height / 2) - targetHeight,
//                            width: targetWidth,
//                            height: targetHeight))
                        
                        self?.thumbnail.image = img
                    }
                }
            }
        }
        
    }

    func resizeHeightCrop(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
//        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//        } else {
//            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
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
    
    func resize(image: UIImage, targetSize: CGSize) -> UIImage {
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

    private func cropImage(image: UIImage , cropRect: CGRect) -> UIImage {
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
