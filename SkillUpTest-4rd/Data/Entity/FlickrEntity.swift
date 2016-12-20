//
//  FlickrEntity.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import ObjectMapper

struct FlickrEntity: Mappable {

    struct Photos: Mappable {

        struct Photo: Mappable {

            var id = ""
            var owner = ""
            var secret = ""
            var server = ""
            var farm = 0
            var title = ""
            var ispublic = 0
            var isfriend = 0
            var isfamily = 0

            init?(map: Map) {}

            mutating func mapping(map: Map) {
                id <- map["id"]
                owner <- map["owner"]
                secret <- map["secret"]
                server <- map["server"]
                farm <- map["farm"]
                title <- map["title"]
                ispublic <- map["ispublic"]
                isfriend <- map["isfriend"]
                isfamily <- map["isfamily"]
            }
        }

        var page = 0
        var pages = 0
        var perpage = 0
        var total = ""
        var photo: [Photo]?

        init?(map: Map) {}

        mutating func mapping(map: Map) {
            page <- map["page"]
            pages <- map["pages"]
            perpage <- map["perpage"]
            total <- map["total"]
            photo <- map["photo"]
        }
    }

    var stat = ""
    var photos: Photos?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        stat <- map["stat"]
        photos <- map["photos"]
    }
}
