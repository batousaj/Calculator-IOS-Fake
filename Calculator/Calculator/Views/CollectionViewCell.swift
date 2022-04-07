//
//  CollectionViewCell.swift
//  Calculator
//
//  Created by Mac Mini 2021_1 on 06/04/2022.
//

import Foundation
import UIKit

class CollectionViewCell : UICollectionViewCell {
    
    let label:UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = self.contentView.frame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addSubview(label)
        self.setCircleItems(label)
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setItems (_ title : String, color : UIColor, textColor: UIColor, textSize: Int) {
        label.text = title
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: CGFloat(textSize))
        label.backgroundColor = color
        label.textColor = textColor
    }
    
    private func setCircleItems(_ label:UILabel) {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 42
        
    }
}
