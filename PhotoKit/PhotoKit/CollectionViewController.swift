//
//  CollectionViewController.swift
//  PhotoKit
//
//  Created by  on 2017. 7. 27..
//  Copyright © 2017년 H-Lab. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    let reuseIndetifier = "ImageCell"
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndetifier, for: indexPath) as! CollectionViewCell
        
        let image = UIImage(named: "0\(indexPath.row + 1).jpg")
        cell.ImageView.image = image
        
        return cell
    }
    
    
    
}






















