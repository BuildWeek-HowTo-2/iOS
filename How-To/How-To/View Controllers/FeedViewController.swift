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

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 16, height: 100)
    }
}

extension FeedViewController: BookmarkCellDelegate {
    func toggleBookmark(for cell: HowToCollectionViewCell) {
        //guard let item = cell.howto else { return }
        //shoppingItemController.updateHasBeenAdded(for: item)
        //collectionView?.reloadData()
    }
}
