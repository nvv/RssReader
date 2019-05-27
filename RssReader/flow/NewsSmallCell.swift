//
//  NewsCell.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/26/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

class NewsSmallCell: BaseNewsCell {
    
//    weak var textLabel: UILabel!
    
//    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let textLabel = UILabel(frame: .zero)
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.contentView.addSubview(textLabel)
//        NSLayoutConstraint.activate([
//            textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
//            textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//            textLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
//            ])
//        self.textLabel = textLabel
//
//        self.contentView.backgroundColor = .lightGray
//        self.textLabel.textAlignment = .center
    }
    
    override func bind(_ newsItem: NewsItem) {
        super.bind(newsItem)
        self.title.text = rssNewsItem?.title
        
        let width = self.bounds.width
        let height = self.bounds.height / 1.8
        
        DispatchQueue.global().async { [weak self] in
            if let thumbnail = newsItem.thumbnail {
                
                let url = URL(string: thumbnail)
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            
                            print(">>>  " + newsItem.title)
                            print(">>>  " + String(Int(image.size.width)) + "  " + String(Int(image.size.height)))

                            
                            self?.thumbnail.contentMode = .scaleAspectFit
                            let img = self?.resizeHeightCrop(image: image, targetSize: CGSize(width: width, height: height))
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
