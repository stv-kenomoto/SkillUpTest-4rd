//
//  GetFlickr.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import RxSwift

final class GetFlickr {

    let disposeBag = DisposeBag()

    let flickrRepository: FlickrRepository

    init(flickrRepository: FlickrRepository) {
        self.flickrRepository = flickrRepository
    }
}


// MARK: - GetFlickrUseCase
extension GetFlickr: GetFlickrUseCase {

    func execute(tag: String, page: Int,_ on: @escaping (Event<FlickrModel>) -> Void) {
        flickrRepository.flickrObservable(tag: tag, page: page)
            .subscribe(on)
            .addDisposableTo(disposeBag)
    }
}

