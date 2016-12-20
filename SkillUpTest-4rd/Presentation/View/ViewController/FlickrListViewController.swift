//
//  FlickrListViewController.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import UIKit

protocol FlickrListViewControllerDelegate: class {

    func flickrListViewControllerDidEndScroll()
}

final class FlickrListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    weak var delegate: FlickrListViewControllerDelegate?

    private let flickrListDataSource = FlickrListDataSource()

    private let tableViewEstimatedRowHeight: CGFloat = 140

    var flickrModel: FlickrModel? {
        get {
            return flickrListDataSource.flickrModel
        }
        set {
            if flickrListDataSource.flickrModel == nil {
                flickrListDataSource.flickrModel = newValue
                setupTableView()
            } else {
                flickrListDataSource.flickrModel = newValue
                tableView.reloadData()
            }
        }
    }

    func addFlickrModel(additionFlickrModel: FlickrModel) {
        guard let flickrModel = flickrListDataSource.flickrModel else {
            return
        }

        flickrListDataSource.flickrModel?.page = additionFlickrModel.page
        flickrListDataSource.flickrModel?.photo = flickrModel.photo + additionFlickrModel.photo
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.register(FlickrListCell.self)
        tableView.estimatedRowHeight = tableViewEstimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = flickrListDataSource
        tableView.delegate = self
    }
}

// MARK - UITableViewDelegate
extension FlickrListViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y >= tableView.contentSize.height - tableView.bounds.size.height {
            delegate?.flickrListViewControllerDidEndScroll()
        }
    }
}
