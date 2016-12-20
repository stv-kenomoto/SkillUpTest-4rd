//
//  FlickrModel.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import Foundation

struct FlickrModel {

    struct Photo {
        let title: String
        let url: URL?
    }

    var page: Int
    let pages: Int
    var photo: [Photo]
}
