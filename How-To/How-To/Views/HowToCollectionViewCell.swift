//
//  HowToCollectionViewCell.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

protocol BookmarkCellDelegate: class {
    func toggleBookmark(for cell: HowToCollectionViewCell)
}

class HowToCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: BookmarkCellDelegate?
    
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
        // Add to CoreData here

        delegate?.toggleBookmark(for: self)
        //bookmarkButton.setImage(UIImage(named: "bookmark.fill"), for: .normal)
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
    }
}
