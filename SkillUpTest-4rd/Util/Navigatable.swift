//
//  Navigatable.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import UIKit

import UIKit

protocol Navigatable {

    static func viewController<T: UIViewController>(storyboardName: String, storyboardID: String) -> T
}

extension Navigatable {

    static func viewController<T: UIViewController>(storyboardName: String, storyboardID: String) -> T {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardID) as! T
    }
}

extension UIStoryboard : Navigatable {

    private struct Name {
        static let FlickrList = "FlickrList"
        static let FlickrGrid = "FlickrGrid"
    }

    private struct ID {
        static let FlickrList = "FlickrList"
        static let FlickrGrid = "FlickrGrid"
    }

    static func flickrListViewController() -> FlickrListViewController {
        return viewController(storyboardName: Name.FlickrList, storyboardID: Name.FlickrList)
    }

    static func flickrGridViewController() -> FlickrGridViewController {
        return viewController(storyboardName: ID.FlickrGrid, storyboardID: ID.FlickrGrid)
    }
}
