//
//  BookmarkCollectionViewCell.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class BookmarkCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    /*
     PASS OBJECT HERE {
        didSet {
            updateViews()
        }
     }
    */
    
    // MARK: - Private Methods
    private func updateViews() {
        
    }
    
    // MARK: - IBActions
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        // Remove from CoreData here
    }
    
}
