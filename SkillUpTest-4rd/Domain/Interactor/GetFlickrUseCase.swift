//
//  GetFlickrUseCase.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import RxSwift

protocol GetFlickrUseCase {

    func execute(tag: String, page: Int,_ on: @escaping (Event<FlickrModel>) -> Void)
}
