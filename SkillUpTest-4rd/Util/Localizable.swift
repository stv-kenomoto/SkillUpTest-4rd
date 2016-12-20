//
//  Localizable.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import UIKit

protocol Localizable {

    associatedtype Key: RawRepresentable
}

extension Localizable where Key.RawValue == String {

    @discardableResult
    func localized(forKey key: Key) -> String {
        let key = key.rawValue
        let comment = key
        return NSLocalizedString(key, comment: comment)
    }
}

extension String: Localizable {

    enum Key : String {
        case pleaseEnterKeywords
        case networkError
        case notExistPhoto
    }
}
