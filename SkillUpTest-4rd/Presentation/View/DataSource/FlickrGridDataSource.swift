//
//  FlickrGridDataSource.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import UIKit

final class FlickrGridDataSource: NSObject {

    var flickrModel: FlickrModel?
}

// MARK - UICollectionViewDataSource
extension FlickrGridDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = flickrModel?.photo.count else {
            return 0
        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flickrGridCell: FlickrGridCell = collectionView.dequeueReusableCell(for: indexPath)

        guard let photo = flickrModel?.photo[indexPath.row] else {
            return flickrGridCell
        }

        flickrGridCell.set(photo: photo)
        return flickrGridCell;
    }

}
