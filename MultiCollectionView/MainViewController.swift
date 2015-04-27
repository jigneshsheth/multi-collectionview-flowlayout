//
//  MainViewController.swift
//  MultiCollectionView
//
//  Created by Jigs Sheth on 1/21/15.
//  Copyright (c) 2015 Jigs Sheth. All rights reserved.
//

import UIKit

let cellItemID = "ItemCellID"
class MainViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var smallListLayout:CustomCollectionViewFlowLayout?
  private var mediumListLayout:CustomCollectionViewFlowLayout?
  private var gridLayout:CustomCollectionViewFlowLayout?
  
  private var previousIndex:NSIndexPath?
  
  override func awakeFromNib() {
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let viewWidth = self.view.frame.size.width
    self.gridLayout = CustomCollectionViewFlowLayout.gridLayout(viewWidth)
    self.mediumListLayout = CustomCollectionViewFlowLayout.mediumListLayout(viewWidth)
    self.smallListLayout = CustomCollectionViewFlowLayout.smallListLayout(viewWidth)
    self.collectionView?.registerClass(UICollectionViewCell.self,forCellWithReuseIdentifier:cellItemID)
    self.collectionView?.setCollectionViewLayout(self.gridLayout!, animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  //MARK: CollectionViewDataSource
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 50
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  //MARK: CollectionViewDelegates
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    var cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellItemID, forIndexPath: indexPath) as! UICollectionViewCell
    cell.backgroundColor = UIColor.yellowColor()
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
      var layout = collectionViewLayout as! UICollectionViewFlowLayout
      return layout.itemSize
  }
  
  @IBAction func changeLayout(sender: AnyObject) {
    self.updateLayout()
  }
  
  private func updateLayout(){
    self.collectionView?.collectionViewLayout.invalidateLayout()
    if let currentLayout = self.collectionView?.collectionViewLayout {
      var layout = (currentLayout == self.gridLayout!) ? self.mediumListLayout:(currentLayout == self.smallListLayout!) ? self.gridLayout:self.smallListLayout
      if let layout = layout{
        self.collectionView?.setCollectionViewLayout(layout, animated: true)
      }
    }
    self.collectionView.reloadData()
  }}
