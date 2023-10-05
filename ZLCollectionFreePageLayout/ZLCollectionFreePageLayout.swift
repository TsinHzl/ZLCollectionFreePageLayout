//
//  ZLCollectionFreePageLayout.swift
//  XTPro
//
//  Created by harllan on 2023/9/28.
//

import UIKit


open class ZLCollectionFreePageLayout: UICollectionViewFlowLayout {
    
    /// your custom page width or page height
    /// if `scrollDirection == .horizontal`, `pageWOrH` is page width, otherwise it is page height
    /// if `pageWOrH == 0`, it will be set to the width or height of collection view
    open var pageWOrH: CGFloat = 0
    
    open override var collectionViewContentSize: CGSize {
        get {
            
            if prevContentSize == super.collectionViewContentSize { return prevCalculatedContentSize }
            
            let contentSize = super.collectionViewContentSize
            prevContentSize = contentSize
            
            var contentWOrH: CGFloat = 0
            var pWOrH: CGFloat = 0
            var collectionWOrH: CGFloat = 0
            
            if scrollDirection == .horizontal {
                contentWOrH = contentSize.width
                collectionWOrH = collectionView?.frame.size.width ?? contentSize.width
                pWOrH = (pageWOrH == 0 ? (collectionView?.frame.width ?? 0) : pageWOrH) + minimumLineSpacing
            } else {
                contentWOrH = contentSize.height
                collectionWOrH = collectionView?.frame.size.height ?? contentSize.height
                pWOrH = (pageWOrH == 0 ? (collectionView?.frame.height ?? 0) : pageWOrH) + minimumInteritemSpacing
            }
            
            let wh = contentWOrH - pWOrH + collectionWOrH
            if scrollDirection == .horizontal {
                prevCalculatedContentSize = CGSize(width: wh + minimumLineSpacing, height: contentSize.height)
            } else {
                prevCalculatedContentSize = CGSize(width: contentSize.width, height: wh + minimumInteritemSpacing)
            }
            
            return prevCalculatedContentSize
        }
    }
    
    private var prevContentSize: CGSize = .zero
    private var prevCalculatedContentSize: CGSize = .zero
    
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
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
        
        let originalPage = contentOffsetXOrY / pWOrH
        var nextPage = (velocityXOrY > 0) ? ceil(originalPage) : floor(originalPage)
        if (nextPage + 1.0) * pWOrH > collectionViewContentWOrH { nextPage -= 1.0 }
        
        let currentPage = (velocityXOrY > 0) ? floor(originalPage) : ceil(originalPage)
        let pannedLessThanOnePage = abs(1 + currentPage - originalPage) > 0.5
        let flicked = abs(velocityXOrY) > 0.01
        
        var newProposedContentOffset = proposedContentOffset
        if !(pannedLessThanOnePage && flicked) {
            nextPage = round(originalPage)
        }
        
        newProposedContentOffset.x = nextPage * pWOrH
        
        return newProposedContentOffset
    }
}
