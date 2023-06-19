//
//  UICollectionViewExtension.swift
//  House
//
//  Created by Usman Tarar on 17/01/2021.
//  Copyright © 2021 Ahmed samir ali. All rights reserved.
//

import UIKit
import SmilesLanguageManager



public class RTLCollectionViewFlowLayout: UICollectionViewFlowLayout {

    public override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        if SmilesLanguageManager.shared.currentLanguage == .ar {
            return true
        } else {
            return false
        }
    }
}

public protocol SemanticLayoutDelegate: UICollectionViewDelegateFlowLayout {
    func semanticDisposition() -> SemanticDisposition
}

public enum SemanticDisposition {
    case leftToRigth
    case rigthToLeft
}

public class SemanticLayout: UICollectionViewFlowLayout {

    weak var delegate: SemanticLayoutDelegate!

    fileprivate var cellPadding: CGFloat = 10

    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    fileprivate var contentHeight: CGFloat = 0
    private var rowsWidth : [CGFloat] = [0]
    private var avaiableSpaces : [(Int,CGFloat)] = []
    private var currentRow : Int = 0
    private var rowHeigths : CGFloat = -1.0

    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    private func availableWidthForRow(index:Int) -> CGFloat {
        let ocuppedWidth = self.rowsWidth[index]
        return self.contentWidth - ocuppedWidth
    }

    private func canAddCellAtRow(rowIndex:Int,size:CGSize) ->Bool
    {
        if(availableWidthForRow(index: rowIndex) >= size.width) {
            return true
        }

        return false
    }

    public override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    public override func prepare() {
        // Check if cache is empty
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }

        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {

            let indexPath = IndexPath(item: item, section: 0)

            let viewSize: CGSize = delegate.collectionView!(collectionView, layout: self, sizeForItemAt: indexPath)
            if(self.rowHeigths < 0) {
                self.rowHeigths = viewSize.height
            }

            let width = viewSize.width
            let height = viewSize.height

            var xOffset = self.rowsWidth[self.currentRow]
            if(self.canAddCellAtRow(rowIndex: self.currentRow, size: viewSize)) {

                if(self.delegate.semanticDisposition() == .rigthToLeft) {
                    xOffset = (contentWidth - self.rowsWidth[self.currentRow]) - width
                }

            } else {
                self.currentRow += 1
                self.rowsWidth.append(0.0)
                xOffset = self.rowsWidth[self.currentRow]
                if(self.delegate.semanticDisposition() == .rigthToLeft) {
                    xOffset = (contentWidth - self.rowsWidth[self.currentRow]) - width
                }

            }

            let yOffset = CGFloat(self.currentRow) * self.rowHeigths

            let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            contentHeight = max(contentHeight, frame.maxY)

            self.rowsWidth[self.currentRow]  += width
        }
    }

    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}

public class SnappingCollectionViewLayout: UICollectionViewFlowLayout {

    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left

        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)

        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)

        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
