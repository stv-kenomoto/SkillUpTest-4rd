//
//  FlickrRouting.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import Swinject
import UIKit

protocol FlickrRouting {

    var container: Container { get }
}

extension FlickrRouting where Self: UIViewController {

    var container: Container {
        let container = Container()
        container.register(FlickrNet.self) { _ in FlickrAPI() }

        container.register(FlickrRepository.self) { r in
            FlickrDataRepository(flickrNet: r.resolve(FlickrNet.self)!)
        }

        container.register(GetFlickrUseCase.self) { r in
            GetFlickr(flickrRepository: r.resolve(FlickrRepository.self)!)
        }

        return container
    }
}

extension FlickrViewController: FlickrRouting {}
