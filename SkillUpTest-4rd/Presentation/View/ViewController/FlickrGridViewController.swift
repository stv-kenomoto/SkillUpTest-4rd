//
//  FlickrGridViewController.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import UIKit

protocol FlickrGridViewControllerDelegate: class {

    func flickrGridViewControllerDidEndScroll()
}

final class FlickrGridViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    weak var delegate: FlickrGridViewControllerDelegate?

    private let flickrGridDataSource = FlickrGridDataSource()

    var flickrModel: FlickrModel? {
        get {
            return flickrGridDataSource.flickrModel
        }
        set {
            if flickrGridDataSource.flickrModel == nil {
                flickrGridDataSource.flickrModel = newValue
                setupCollectionView()
            } else {
                flickrGridDataSource.flickrModel = newValue
                collectionView.reloadData()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let cellWidth = floor(collectionView.bounds.width / 2)
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
    }

    func addFlickrModel(additionFlickrModel: FlickrModel) {
        guard let flickrModel = flickrGridDataSource.flickrModel else {
            return
        }

        flickrGridDataSource.flickrModel?.page = additionFlickrModel.page
        flickrGridDataSource.flickrModel?.photo = flickrModel.photo + additionFlickrModel.photo
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        collectionView.register(FlickrGridCell.self)
        collectionView.dataSource = flickrGridDataSource
        collectionView.delegate = self
    }
}

// MARK - UICollectionViewDelegate
extension FlickrGridViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y >= collectionView.contentSize.height - collectionView.bounds.size.height {
            delegate?.flickrGridViewControllerDidEndScroll()
        }
    }
}
