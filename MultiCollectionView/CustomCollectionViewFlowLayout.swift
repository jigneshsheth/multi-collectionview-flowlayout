//
//  CustomCollectionViewFlowLayout.swift
//  MultiCollectionView
//
//  Created by Jigs Sheth on 1/20/15.
//  Copyright (c) 2015 Jigs Sheth. All rights reserved.
//

import UIKit
import QuartzCore

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
  
  var indexPathsToAnimate:[AnyObject] = [AnyObject]()
  
  private  class func flowlayout(itemSize:CGSize,minLineSpacing:CGFloat, minItemSpacing:CGFloat) -> CustomCollectionViewFlowLayout{
    
    var flowlayout = CustomCollectionViewFlowLayout()
    flowlayout.itemSize = itemSize
    flowlayout.minimumInteritemSpacing = minItemSpacing
    flowlayout.minimumLineSpacing = minLineSpacing
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
    return flowlayout
  }
  
  class func smallListLayout(viewWidth:CGFloat) -> CustomCollectionViewFlowLayout{
    return flowlayout(CGSizeMake(viewWidth - 30 ,80), minLineSpacing: 5, minItemSpacing: 5)
  }
  
  class func mediumListLayout(viewWidth:CGFloat) -> CustomCollectionViewFlowLayout{
    return flowlayout(CGSizeMake(viewWidth - 30,280), minLineSpacing: 5, minItemSpacing: 5)
  }
  
  class func gridLayout(viewWidth:CGFloat) -> CustomCollectionViewFlowLayout{
    let itemWidth = (viewWidth - 30) / 2
    return flowlayout(CGSizeMake(itemWidth, itemWidth), minLineSpacing: 5, minItemSpacing: 5)
  }
  
  override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes?{
    var att = self.layoutAttributesForItemAtIndexPath(itemIndexPath)
    if self.indexPathsToAnimate.count > 0 {
    var obj:AnyObject? = self.indexPathsToAnimate[itemIndexPath.row]
    if let o: AnyObject = obj  {
      att.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), CGFloat(M_PI))
      att.center = CGPointMake(CGRectGetMaxX(self.collectionView!.bounds), CGRectGetMaxX(self.collectionView!.bounds))
      self.indexPathsToAnimate.removeAtIndex(itemIndexPath.row)
      }}
    return att
  }
  
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    var oldBounds = self.collectionView?.bounds
    if let oldBounds = oldBounds {
      if !CGSizeEqualToSize(oldBounds.size, newBounds.size) {
        return true
      }
    }
    return false
  }
  
  override func prepareForCollectionViewUpdates(updateItems: [AnyObject]!) {
    super.prepareForCollectionViewUpdates(updateItems)
    
    var indexPaths = [AnyObject]()
    
    for updateItem in updateItems {
      var item:UICollectionViewUpdateItem = updateItem as! UICollectionViewUpdateItem
      switch item.updateAction {
      case UICollectionUpdateAction.Insert:
        indexPaths.append(item.indexPathAfterUpdate!)
        break
      case UICollectionUpdateAction.Delete:
        indexPaths.append(item.indexPathBeforeUpdate!)
        break
      case UICollectionUpdateAction.Move:
        indexPaths.append(item.indexPathBeforeUpdate!)
        indexPaths.append(item.indexPathAfterUpdate!)
        break
      default:
        println("Unhandled case:: \(updateItems)")
        break
      }
    }
    
    self.indexPathsToAnimate = indexPaths
    
  }
  
   
}
