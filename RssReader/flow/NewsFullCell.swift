//
//  NewsFullCell.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/26/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class NewsFullCell: BaseImageCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func bind(_ newsItem: FeedItem) {
        super.bind(newsItem)
        self.title.text = rssNewsItem?.title
        
        let width = self.bounds.width
        let height = self.bounds.height / 1.2
        
        DispatchQueue.global().async { [weak self] in
            if let thumbnail = newsItem.thumbnail {
                
                let url = URL(string: thumbnail)
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.thumbnail.contentMode = .scaleAspectFit
                            let img = self?.resizeCropCenter(image: image, targetSize: CGSize(width: width, height: height), resizeAdjust: .width)
                            self?.thumbnail.image = img
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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.title.text = nil
    }
    
    
}
