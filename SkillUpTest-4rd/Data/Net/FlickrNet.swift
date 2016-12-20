//
//  FlickrNet.swift
//  SkillUpTest-4rd
//
//  Created by kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import RxSwift

protocol FlickrNet {

    func flickrObservable(tag: String, page: Int) -> Observable<FlickrEntity>
}
