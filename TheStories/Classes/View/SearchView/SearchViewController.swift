//
//  SearchViewController.swift
//  TheStories
//
//  Created by Wil Liam on 7/1/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerSearchView: HeaderSearchView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var event: SearchViewEvent?

    private(set) var photosList = [Photo]()
    private(set) var images = [ImageViewModel]()

    private(set) var keyword = ""
    private(set) var isLoading = true
    private(set) var totalPage = 0
    private(set) var position = 0

    fileprivate var alertView: AlertView?
    fileprivate(set) var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "search"

        configureSearchBar()

        configureCollectionView()
    }

    private func configureSearchBar() {
//        headerSearchView.searchBar.becomeFirstResponder()
        headerSearchView.searchBar.delegate = self
    }

    private func configureCollectionView() {
        // Customize UICollectionViewLayout
        var contentInset = UIEdgeInsets(top: headerSearchView.frame.size.height + 10,
                                        left: 10,
                                        bottom: 10,
                                        right: 10)
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            contentInset.top -= (window.safeAreaInsets.top - 10)
        }

        collectionView.contentInset = contentInset
        collectionView.scrollIndicatorInsets = collectionView.contentInset

        // Register cell
        collectionView.register(UINib(nibName: PhotoViewCell.reuseIdentifier(), bundle: nil),
                                forCellWithReuseIdentifier: PhotoViewCell.reuseIdentifier())

        let customLayout = CustomLayout()
        customLayout.delegate = self

        collectionView.collectionViewLayout = customLayout
    }

    func showListPhotos(withPhotos photos: [Photo], page: Int, imageViewModel: [ImageViewModel]) {
        collectionView.performBatchUpdates({
            var indexPath = [IndexPath]()
            var index = 0

            for row in totalPage..<page {
                self.photosList.append(photos[index])
                self.images.append(imageViewModel[index])

                indexPath.append(IndexPath(row: row, section: 0))
                index += 1
            }

            collectionView.insertItems(at: indexPath)
        }, completion: nil)

        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true

        self.isLoading = false
        self.totalPage = page
        self.position += 1

        self.collectionView.reloadData()
    }

    func showErrorRequest(error: ErrorRespond) {
        guard var alert = alertView else { return }

        alert = AlertView(title: nil, message: error.message)
        self.present(alert, animated: true, completion: nil)
    }

    private func cleanData() {
        if images.count > 0 {
            debugPrint("Cleaning data...")

            self.images = [ImageViewModel]()
            self.photosList = [Photo]()
            self.totalPage = 0
            self.position = 0
            self.isLoading = true

            collectionView.reloadData()
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            cleanData()
        } else {
            searchBar.text = searchText.capitalized
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }

        // Cleaning data
        cleanData()

        self.keyword = keyword

        event?.onSearch(keyword: keyword, startPage: 1, perPage: 30)

        activityIndicator.startAnimating()
        activityIndicator.isHidden = false

        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Make sure data is cleaned
        cleanData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

// MARK: - CustomLayoutDelegate
extension SearchViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return images[indexPath.item].image.size
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        switch cell {
        case is PhotoViewCell:
            guard let cell = cell as? PhotoViewCell else { return }

            let image = images[indexPath.item].image
            cell.photoImageView.image = image
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.reuseIdentifier(),
                                                  for: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percentScrolled = (scrollView.contentOffset.y + UIScreen.main.bounds.size.height)
            / scrollView.contentSize.height
        if isLoading == false, percentScrolled >= 0.8 {
            isLoading = true

            event?.onSearch(keyword: keyword, startPage: position,
                            perPage: 30 + self.photosList.count)
        }
    }
}
