//
//  FlickrDataRepository.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import RxSwift

final class FlickrDataRepository {

    let flickrNet: FlickrNet

    init(flickrNet: FlickrNet) {
        self.flickrNet = flickrNet
    }
}

// MARK - FlickrModelMapping
extension FlickrDataRepository: FlickrModelMapping {}

// MARK: - FlickrRepository
extension FlickrDataRepository: FlickrRepository {

    func flickrObservable(tag: String, page: Int) -> Observable<FlickrModel> {
        return flickrNet.flickrObservable(tag: tag, page: page)
            .map { flickrEntity in
                return self.transform(flickrEntity)
            }
    }
}
