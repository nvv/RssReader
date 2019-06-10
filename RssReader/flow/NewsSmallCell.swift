//
//  NewsCell.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/26/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class NewsSmallCell: BaseNewsCell {
    
    static let maxLines = 4
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsDescription: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func bind(_ newsItem: FeedItem) {
        super.bind(newsItem)
        title.text = rssNewsItem?.title
        
        let width = self.bounds.width
        let height = self.bounds.height / 1.8
        
        DispatchQueue.global().async { [weak self] in
            if let thumbnail = newsItem.thumbnail {
                
                let url = URL(string: thumbnail)
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.thumbnail.contentMode = .scaleAspectFit
                            let img = self?.resizeHeightCrop(image: image, targetSize: CGSize(width: width, height: height))
                            self?.thumbnail.image = img
                        
                            if let titleLines = self?.title.calculateMaxLines() {
                                let descriptionLines = NewsSmallCell.maxLines - titleLines

                                self?.title.numberOfLines = titleLines <= NewsSmallCell.maxLines ? titleLines : NewsSmallCell.maxLines
                                self?.newsDescription.textContainer.maximumNumberOfLines = descriptionLines > 0 ? descriptionLines : 0
                                
                                self?.newsDescription.text = descriptionLines > 0 ? self?.rssNewsItem?.description ?? "" : ""
                                self?.title.text = self?.rssNewsItem?.title
                            }
                        }
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsDescription.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
        newsDescription.text = nil
    }
}
