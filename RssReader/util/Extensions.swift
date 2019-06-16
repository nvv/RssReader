//
//  Extensions.swift
//  RssReader
//
//  Created by Vlad Namashko on 5/20/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import UIKit

extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        let linesRoundedUp = Int(textSize.height / charSize)
        return linesRoundedUp
    }
    
}
