//
//  FlickrPresenter.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import RxSwift

final class FlickrPresenter {

    let getFlickrUseCase: GetFlickrUseCase

    weak var flickrView: FlickrView?

    private var flickrTotalPage = 1

    private var flickrPage = 1

    private var flickrTag = ""

    init(getFlickrUseCase: GetFlickrUseCase) {
        self.getFlickrUseCase = getFlickrUseCase
    }

    func searchBarTextDidBeginEditing() {
        flickrView?.showCancelButtonInSearchBar()
    }

    func searchBarTextDidEndEditing() {
        flickrView?.hideCancelButtonInSearchBar()
    }

    func searchBarCancelButtonClicked() {
        flickrView?.hideKeyboardInSearchBar()
    }

    func getFlickr(tag: String) {
        flickrTag = tag
        flickrView?.hideKeyboardInSearchBar()
        flickrView?.showIndicaotor()
        getFlickrUseCase.execute(tag: flickrTag, page: flickrPage) { [weak self] event in
            guard let weakSelf = self else {
                return
            }

            switch event {
            case .next(let flickrModel):
                if flickrModel.photo.isEmpty {
                    weakSelf.flickrView?.showError(message: String().localized(forKey: .notExistPhoto))
                } else {
                    weakSelf.flickrTotalPage = flickrModel.pages
                    weakSelf.flickrPage = weakSelf.flickrPage + 1
                    weakSelf.flickrView?.renderFlickr(flickrModel: flickrModel)
                }
                break

            case .error:
                weakSelf.flickrView?.showError(message: String().localized(forKey: .networkError))
                break

            case .completed:
                break
            }
        }
    }

    func addFlickr() {
        guard let flickrView = flickrView else {
            return
        }

        if flickrView.isAddtionIndicatorShowing() {
            return
        }

        if flickrTotalPage <= flickrPage {
            return
        }
        
        flickrView.showAddtionIndicator()
        getFlickrUseCase.execute(tag: flickrTag, page: flickrPage) { [weak self] event in
            guard let weakSelf = self else {
                return
            }

            switch event {
            case .next(let flickrModel):
                weakSelf.flickrPage = weakSelf.flickrPage + 1
                if !flickrModel.photo.isEmpty {
                    weakSelf.flickrView?.addFlickr(flickrModel: flickrModel)
                }
                break

            case .error:
                break

            case .completed:
                break
            }

            weakSelf.flickrView?.hideAddtionIndicator()
        }
    }
}
