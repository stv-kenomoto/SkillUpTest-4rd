//
//  FlickrListCell.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import SDWebImage
import UIKit

final class FlickrListCell: UITableViewCell{

    @IBOutlet weak var thumbnailImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    override func prepareForReuse() {
        thumbnailImageView.image = nil
        titleLabel.text = ""
    }

    func set(photo: FlickrModel.Photo) {
        thumbnailImageView.sd_setImage(with: photo.url)
        titleLabel.text = photo.title
    }
}
