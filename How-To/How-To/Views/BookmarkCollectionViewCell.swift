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
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var tutorial: Guide? {
        didSet {
            updateViews()
        }
     }
    
    // MARK: - Private Methods
    private func updateViews() {
        guard let tutorial = tutorial else { return }
        titleLabel.text = tutorial.title
        captionLabel.text = tutorial.summary
    }
    
    // MARK: - IBActions
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        // Remove from CoreData here
    }
    
}
