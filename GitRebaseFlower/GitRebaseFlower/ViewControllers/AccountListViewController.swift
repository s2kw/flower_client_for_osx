//
//  AccountListViewController.swift
//  GitRebaseFlower
//
//  Created by Kunihiro SASAKAWA on 2/20/15.
//  Copyright (c) 2015 jigaX. All rights reserved.
//

import AppKit
import Foundation

class AccountListViewController: NSViewController, NSCollectionViewDelegate {
    
    var hoge: BranchModel!
    var hogeArray: NSMutableArray!
    
    @IBOutlet weak var hogeCollectionView: NSCollectionView!
    @IBOutlet var arrayController: NSArrayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemPrototype = self.storyboard?.instantiateControllerWithIdentifier("collectionViewItem")
            as NSCollectionViewItem
        hogeCollectionView.itemPrototype = itemPrototype
        hoge = BranchModel()
        hogeArray = NSMutableArray(array:[hoge, hoge, hoge])
        hogeCollectionView.content = hogeArray
    }
}