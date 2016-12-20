//
// Flickr ViewController.swift
//  SkillUpTest-4rd
//
//  Created by Kouki Enomoto on 2016/12/17.
//  Copyright © 2016年 enomt. All rights reserved.
//

import UIKit

final class FlickrViewController: UIViewController {

    private enum Format {
        case list
        case grid
    }

    @IBOutlet weak var flickrView: UIView!

    @IBOutlet weak var messageLabel: UILabel!

    @IBOutlet weak var indicator: UIActivityIndicatorView!

    @IBOutlet weak var additionIndicator: UIActivityIndicatorView!

    let searchBar = UISearchBar()

    let flickrListViewController = UIStoryboard.flickrListViewController()

    let flickrGridViewController = UIStoryboard.flickrGridViewController()

    var flickrPresenter: FlickrPresenter?

    var currentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        flickrListViewController.delegate = self
        flickrGridViewController.delegate = self

        setupSearchBar()
        setupFlickrPresenter()
        addFrickrChildViewController(flickrListViewController)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flickrListViewController.view.frame = flickrView.bounds
        flickrGridViewController.view.frame = flickrView.bounds
    }

    @IBAction func segmentedControlValueDidChanging(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case Format.list.hashValue:
            if currentViewController == flickrListViewController {
                return
            }

            removeFrickrChildViewController()
            addFrickrChildViewController(flickrListViewController)
            break

        default:
            if currentViewController == flickrGridViewController {
                return
            }

            removeFrickrChildViewController()
            addFrickrChildViewController(flickrGridViewController)
        }
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = String().localized(forKey: .pleaseEnterKeywords)
        self.navigationItem.titleView = searchBar
    }

    private func setupFlickrPresenter() {
        guard let getFlickrUseCase = container.resolve(GetFlickrUseCase.self) else {
            return
        }

        flickrPresenter = FlickrPresenter(getFlickrUseCase: getFlickrUseCase)
        flickrPresenter?.flickrView = self
    }

    private func removeFrickrChildViewController() {
        currentViewController?.willMove(toParentViewController: nil)
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParentViewController()
    }

    private func addFrickrChildViewController(_ viewController: UIViewController) {
        addChildViewController(viewController)
        flickrView.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
        currentViewController = viewController
    }
}

// MARK: - FlickrView
extension FlickrViewController: FlickrView {

    func showCancelButtonInSearchBar() {
        searchBar.showsCancelButton = true
    }

    func hideCancelButtonInSearchBar() {
        searchBar.showsCancelButton = false
    }

    func hideKeyboardInSearchBar() {
        searchBar.resignFirstResponder()
    }

    func showIndicaotor() {
        indicator.startAnimating()
        messageLabel.isHidden = true
        flickrView.isHidden = true
    }

    func showAddtionIndicator() {
        additionIndicator.startAnimating()
    }

    func hideAddtionIndicator() {
        additionIndicator.stopAnimating()
    }

    func isAddtionIndicatorShowing() -> Bool {
        return additionIndicator.isAnimating
    }

    func showError(message: String) {
        indicator.stopAnimating()
        messageLabel.isHidden = false
        flickrView.isHidden = true
        messageLabel.text = message
    }

    func renderFlickr(flickrModel: FlickrModel) {
        indicator.stopAnimating()
        messageLabel.isHidden = true
        flickrView.isHidden = false
        flickrListViewController.flickrModel = flickrModel
        flickrGridViewController.flickrModel = flickrModel
    }

    func addFlickr(flickrModel: FlickrModel) {
        flickrListViewController.addFlickrModel(additionFlickrModel: flickrModel)
        flickrGridViewController.addFlickrModel(additionFlickrModel: flickrModel)
    }
}

// MARK: - UISearchBarDelegate
extension FlickrViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let tag = searchBar.text else {
            return
        }

        flickrPresenter?.getFlickr(tag: tag)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        flickrPresenter?.searchBarTextDidBeginEditing()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        flickrPresenter?.searchBarTextDidEndEditing()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        flickrPresenter?.searchBarCancelButtonClicked()
    }
}

// MARK: - FlickrListViewControllerDelegate
extension FlickrViewController: FlickrListViewControllerDelegate {

    func flickrListViewControllerDidEndScroll() {
        flickrPresenter?.addFlickr()
    }
}

// MARK - FlickrGridViewControllerDelegate
extension FlickrViewController: FlickrGridViewControllerDelegate {

    func flickrGridViewControllerDidEndScroll() {
        flickrPresenter?.addFlickr()
    }
}
