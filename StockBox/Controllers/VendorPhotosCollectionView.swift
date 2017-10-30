//
//  VendorPhotosCVC.swift
//  StockBox
//
//  Created by Grishma Athavale on 10/29/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class VendorPhotosController:  UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
   
    var featuredPhotos: FeaturedApps? //need to make model for this
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Featured Apps"
        
        featuredPhotos.fetchFeaturedPhotos { (featuredPhotos) -> () in
            self.featuredPhotos = featuredPhotos
            self.collectionView?.reloadData()
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    
}


class VendorDetailsPhotosCVC: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
}
