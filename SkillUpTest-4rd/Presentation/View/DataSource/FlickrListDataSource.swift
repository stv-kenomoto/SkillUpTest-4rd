//
//  FlickrListDataSource.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import UIKit

final class FlickrListDataSource: NSObject {

    var flickrModel: FlickrModel?
}

// MARK - UITableViewDataSource
extension FlickrListDataSource: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = flickrModel?.photo.count else {
            return 0
        }
        return count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flickrListCell: FlickrListCell = tableView.dequeueReusableCell(for: indexPath)

        guard let photo = flickrModel?.photo[indexPath.row] else {
            return flickrListCell
        }

        flickrListCell.set(photo: photo)

        return flickrListCell
    }
}
