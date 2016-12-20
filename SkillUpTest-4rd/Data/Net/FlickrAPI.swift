//
//  FlickrAPI.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import Alamofire
import ObjectMapper
import RxSwift

final class FlickrAPI {

    static let url = "https://api.flickr.com/services/rest/"

    struct Parameter {

        struct Key {
            static let apiKey = "api_key"
            static let tags = "tags"
            static let format = "format"
            static let page = "page"
            static let perPage = "per_page"
            static let method = "method"
            static let nojsoncallback = "nojsoncallback"
            static let privacyFilter = "privacy_filter"
        }

        struct Value {
            static let apiKey = "10ba93bbe49a6480d765ce486673954a"
            static let format = "json"
            static let perPage = 50
            static let method = "flickr.photos.search"
            static let nojsoncallback = 1
            static let privacyFilter = 1
        }
    }
}

// MARK: - FlickrNet
extension FlickrAPI: FlickrNet {

    func flickrObservable(tag: String, page: Int) -> Observable<FlickrEntity> {
        return Observable.create { (observer: AnyObserver<FlickrEntity>)  in
            let parameters: [String: Any] = [Parameter.Key.apiKey: Parameter.Value.apiKey,
                                             Parameter.Key.format: Parameter.Value.format,
                                             Parameter.Key.perPage: Parameter.Value.perPage,
                                             Parameter.Key.method: Parameter.Value.method,
                                             Parameter.Key.nojsoncallback: Parameter.Value.nojsoncallback,
                                             Parameter.Key.privacyFilter: Parameter.Value.privacyFilter,
                                             Parameter.Key.tags:tag,
                                             Parameter.Key.page: page]

            Alamofire.request(FlickrAPI.url, method: .get, parameters: parameters).responseJSON  { response in
                    switch response.result {
                    case .success(let value):
                        if let flickrEntity = Mapper<FlickrEntity>().map(JSONObject: value) {
                            observer.onNext(flickrEntity)
                            observer.onCompleted()
                        } else {
                            observer.onError(DataError.flickrAPI)
                        }
                        break

                    case .failure:
                        observer.onError(DataError.flickrAPI)
                        break
                    }
            }

            return Disposables.create()
        }
    }
}
