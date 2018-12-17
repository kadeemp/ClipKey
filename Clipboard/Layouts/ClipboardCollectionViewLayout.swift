//
//  ClipboardCollectionViewLayout.swift
//  Clipboard
//
//  Created by Kadeem Palacios on 11/9/17.
//  Copyright © 2017 Kadeem Palacios. All rights reserved.
//

import UIKit
protocol ClipboardCollectionViewDelegate:class {

    func collectionView(_ collectionView:UICollectionView, sizeForTitleAt indexPath: IndexPath) -> CGSize
}

class ClipboardCollectionViewLayout: UICollectionViewLayout {


    // 1
    weak var delegate: ClipboardCollectionViewDelegate?

    // 2
    //fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 4

    // 3
    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    // 4
    fileprivate var contentHeight: CGFloat = 0

    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    // 5
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

}


extension ClipboardCollectionViewLayout {

    override func prepare() {

        guard let collectionView = collectionView,
            let delegate = delegate,
            cache.isEmpty == true
            else {return}

        let section = 0
        let height :CGFloat = 50
        var nextItemMinX:CGFloat = 0
        var nextItemMinY:CGFloat = 0

        //loop through all keys
        for item in 0..<collectionView.numberOfItems(inSection: section) {


            let indexPath = IndexPath(item :item, section:0 )
            let textSize = delegate.collectionView(collectionView, sizeForTitleAt: indexPath)
            let textHeight = textSize.height
            let textWidth = textSize.width + 10
            let width = cellPadding * 3 + textWidth

            //Code for how the cells stack
           // let currentItemMaxX =  nextItemMinX + width

//            if (currentItemMaxX > contentWidth ){
//                nextItemMinX = 0
//                nextItemMinY -= textHeight
//
//            }
            //create frame
            let frame = CGRect(x: nextItemMinX, y: nextItemMinX, width: width, height: height)
            let insetFrame = frame.insetBy(dx:0, dy:0)

            //add frame of cell to cashe for given index
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            //prepare info to calculate next collection view cell

            nextItemMinX = insetFrame.maxX
            //nextItemMinY = frame.maxY


            contentHeight = 300
        }

    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }


    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
