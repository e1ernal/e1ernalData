//
//  CollectionViewController.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    var data = [Photo]()
    
    var registerId: String {
        let id = String(describing: PhotoCollectionViewCell.self)
        return id
    }
    
    @IBOutlet weak var tableCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = tableCollectionView?.collectionViewLayout as? CustomFlowLayout {
          layout.delegate = self
        }

        data = PhotoProvider().photos()
        tableCollectionView.dataSource = self
        tableCollectionView.delegate = self
        tableCollectionView.register(UINib(nibName: registerId, bundle: nil), forCellWithReuseIdentifier: registerId)
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, CustomFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: registerId, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(with: data[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return data[indexPath.item].image.size.height
    }
}
