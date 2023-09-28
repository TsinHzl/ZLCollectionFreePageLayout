//
//  ZLCollectionFreePageLayout.swift
//  XTPro
//
//  Created by harllan on 2023/9/28.
//

import UIKit


class ZLCollectionFreePageLayout: UICollectionViewFlowLayout {
    
    /// your custom page width or page height
    /// if `scrollDirection == .horizontal`, `pageWOrH` is page width, otherwise it is page height
    /// if `pageWOrH == 0`, it will be set to the width or height of collection view
    var pageWOrH: CGFloat = 0
    
    
    override var collectionViewContentSize: CGSize {
        get {
            if prevContentSize == super.collectionViewContentSize { return prevCalculatedContentSize }
            
            let contentSize = super.collectionViewContentSize
            prevContentSize = contentSize
            var contentWOrH: CGFloat = 0
            var collectionWOrH: CGFloat = 0
            
            if scrollDirection == .horizontal {
                contentWOrH = contentSize.width
                collectionWOrH = collectionView?.frame.size.width ?? contentSize.width
            } else {
                contentWOrH = contentSize.height
                collectionWOrH = collectionView?.frame.size.height ?? contentSize.height
            }
            
            let remain = Int(contentWOrH) % Int(collectionWOrH)
            if remain > 0 {
                if scrollDirection == .horizontal {
                    prevCalculatedContentSize = CGSize(width: (contentWOrH - CGFloat(remain)) + collectionWOrH, height: contentSize.height)
                } else {
                    prevCalculatedContentSize = CGSize(width: contentSize.width, height: (contentWOrH - CGFloat(remain)) + collectionWOrH)
                }
                return prevCalculatedContentSize
            }
            
            prevCalculatedContentSize = contentSize
            return prevCalculatedContentSize
        }
    }
    
    private var prevContentSize: CGSize = .zero
    private var prevCalculatedContentSize: CGSize = .zero
    private lazy var storedPageOffsets = [Int: CGPoint]()
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        var pWOrH: CGFloat = 0
        var contentOffsetXOrY: CGFloat = 0
        var collectionViewContentWOrH: CGFloat = 0
        var velocityXOrY: CGFloat = 0
        
        if scrollDirection == .horizontal {
            pWOrH = (pageWOrH == 0 ? collectionView.frame.width : pageWOrH) + minimumLineSpacing
            contentOffsetXOrY = collectionView.contentOffset.x
            collectionViewContentWOrH = collectionViewContentSize.width
            velocityXOrY = velocity.x
        } else {
            pWOrH = (pageWOrH == 0 ? collectionView.frame.height : pageWOrH) + minimumInteritemSpacing
            contentOffsetXOrY = collectionView.contentOffset.y
            collectionViewContentWOrH = collectionViewContentSize.height
            velocityXOrY = velocity.y
        }
        
        let rawPageValue = contentOffsetXOrY / pWOrH
        var nextPage = (velocityXOrY > 0) ? ceil(rawPageValue) : floor(rawPageValue)
        if (nextPage + 1.0) * pWOrH > collectionViewContentWOrH { nextPage -= 1.0 }
        if let offset = storedPageOffsets[Int(nextPage)] { return offset }
        
        let currentPage = (velocityXOrY > 0) ? floor(rawPageValue) : ceil(rawPageValue)
        let pannedLessThanAPage = abs(1 + currentPage - rawPageValue) > 0.5
        let flicked = abs(velocityXOrY) > 0.01
        
        var newProposedContentOffset = proposedContentOffset
        if pannedLessThanAPage && flicked {
            newProposedContentOffset.x = nextPage * pWOrH
        } else {
            newProposedContentOffset.x = round(rawPageValue) * pWOrH
        }
        
        storedPageOffsets[Int(nextPage)] = newProposedContentOffset
        return newProposedContentOffset
    }

}
