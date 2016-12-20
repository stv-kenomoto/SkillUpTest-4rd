//
//  FlickrView.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

protocol FlickrView: class {

    func showCancelButtonInSearchBar()

    func hideCancelButtonInSearchBar()

    func hideKeyboardInSearchBar()

    func showIndicaotor()

    func showAddtionIndicator()

    func hideAddtionIndicator()

    func isAddtionIndicatorShowing() -> Bool

    func showError(message: String)

    func renderFlickr(flickrModel: FlickrModel)

    func addFlickr(flickrModel: FlickrModel)
}
