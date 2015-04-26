//
//  ViewController.swift
//  MultiCollectionView
//
//  Created by Jigs Sheth on 1/20/15.
//  Copyright (c) 2015 Jigs Sheth. All rights reserved.
//

import UIKit

let cellID = "CustomCollectionViewCellID"
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  
  private var collectionView:UICollectionView?
  private var smallListLayout:CustomCollectionViewFlowLayout?
  private var mediumListLayout:CustomCollectionViewFlowLayout?
  private var gridLayout:CustomCollectionViewFlowLayout?
  
  private var previousIndex:NSIndexPath?
  
  override func awakeFromNib() {
    self.setupLayouts()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.gridLayout!)
    self.collectionView?.dataSource = self
    self.collectionView?.delegate = self
    self.collectionView?.registerClass(CustomCollectionViewCell.self,forCellWithReuseIdentifier:cellID)
    self.collectionView?.setCollectionViewLayout(self.gridLayout!, animated: true)
    self.view.addSubview(self.collectionView!)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func setupLayouts(){
    self.setupSmallListLayout()
    self.setupMediumListLayout()
    self.setupGridLayout()
    
  }
  
  
  private func setupSmallListLayout(){
    var layout = CustomCollectionViewFlowLayout.flowlayout(CGSizeMake(300,80), minLineSpacing: 0.5, minItemSpacing: 0.05, inset: UIEdgeInsetsMake(10, 10, 10, 10))
    self.smallListLayout = layout
  }
  
  private func setupMediumListLayout(){
    var layout = CustomCollectionViewFlowLayout.flowlayout(CGSizeMake(300,280), minLineSpacing: 0.5, minItemSpacing: 0.5, inset: UIEdgeInsetsMake(10, 10, 10, 10))
    self.mediumListLayout = layout
  }
  
  private func setupGridLayout(){
    var gridLayout = CustomCollectionViewFlowLayout.flowlayout(CGSizeMake(177, 150), minLineSpacing: 0.5, minItemSpacing: 0.5, inset: UIEdgeInsetsMake(10, 10, 10, 10))
    self.gridLayout = gridLayout
  }
  
  //MARK: CollectionViewDataSource
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 200
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  //MARK: CollectionViewDelegates
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    var cell:CustomCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! CustomCollectionViewCell
    
    if indexPath.item % 2 == 0 {
      cell.backgroundColor = UIColor.redColor()
    }else{
      cell.backgroundColor = UIColor.yellowColor()
    }
    
    return cell
  }
  
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    var newFlowlayout:CustomCollectionViewFlowLayout?
    if indexPath == self.previousIndex {
      self.updateLayout()
    } else if (indexPath != self.previousIndex && self.collectionView?.collectionViewLayout == self.gridLayout){
      newFlowlayout = self.mediumListLayout
    }
    
    if let newLayout = newFlowlayout {
      self.collectionView?.setCollectionViewLayout(newLayout, animated: true)
    }
    self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
    self.previousIndex = indexPath
    
  }
  
  
  @IBAction func changeLayout(sender: AnyObject) {
    
    self.updateLayout()
  }
  
  private func updateLayout(){
    if let currentLayout = self.collectionView?.collectionViewLayout {
      var layout = (currentLayout == self.gridLayout!) ? self.smallListLayout:(currentLayout == self.smallListLayout!) ? self.mediumListLayout:self.gridLayout
      if let newLayout = layout{
        self.collectionView?.setCollectionViewLayout(newLayout, animated: true)
      }
    }
  }
  
  
}

