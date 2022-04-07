//
//  Views.swift
//  Calculator
//
//  Created by Mac Mini 2021_1 on 07/04/2022.
//

import Foundation
import UIKit

class SubViews : UIView {
    
    public var collection:UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    func setupCollectionView(frame: CGRect) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: 85, height: 85)
                
        self.collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.collection.isScrollEnabled = false
        self.collection.backgroundColor = .black
        self.addSubview(self.collection)
    }
    
}
