//
//  FlickrModelMapper.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import Foundation

protocol FlickrModelMapping {

    static var photoURLFormat: String { get }

    func transform(_ flickrEntity: FlickrEntity) -> FlickrModel
}

extension FlickrModelMapping {

    static var photoURLFormat: String {
        return "https://farm%d.staticflickr.com/%@/%@_%@.jpg"
    }

    func transform(_ flickrEntity: FlickrEntity) -> FlickrModel {
        guard let photos = flickrEntity.photos else {
            return FlickrModel(page: 0, pages: 0, photo: [])
        }

        var flickrModelPhotos: [FlickrModel.Photo] = []
        photos.photo?.forEach { photo in
            let url = URL(string: String(format: Self.photoURLFormat, photo.farm, photo.server, photo.id, photo.secret))
            flickrModelPhotos.append(FlickrModel.Photo(title: photo.title, url: url))
        }

        return FlickrModel(page: photos.page, pages: photos.pages, photo: flickrModelPhotos)
    }
}
