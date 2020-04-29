//
//  FeedViewController.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    let apiController = APIController()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        apiController.fetchAllTutorialTitles { (_) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTutorialSegue" {
            guard let selected = collectionView.indexPathsForSelectedItems else { return }
            guard let ViewHowToVC = segue.destination as? ViewHowToViewController else { return }
            ViewHowToVC.tutorial = apiController.tutorials[selected[0].row]
            ViewHowToVC.apiController = apiController
        }
    }
    
    // MARK: - Private Methods
    @objc private func refreshCollectionView(refreshControl: UIRefreshControl) {
        apiController.fetchAllTutorialTitles { (_) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        refreshControl.endRefreshing()
    }

}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiController.tutorials.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HowToCell", for: indexPath) as? HowToCollectionViewCell else { return UICollectionViewCell() }
    
        let tutorial = apiController.tutorials[indexPath.item]
        cell.tutorial = tutorial
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 16, height: 100)
    }
}

extension FeedViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
        print("test")
        apiController.searchTutorialsByID(for: search) { (result) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
