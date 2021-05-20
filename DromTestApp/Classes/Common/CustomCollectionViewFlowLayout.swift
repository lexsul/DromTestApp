//
//  CustomCollectionViewFlowLayout.swift
//  DromTestApp
//
//  Created by Алексей Сулейманов on 07.05.2021.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        
        attribute?.transform = CGAffineTransform.init(translationX: self.collectionViewContentSize.width, y: 0)
        attribute?.alpha = 1.0
        return attribute
    }
}
