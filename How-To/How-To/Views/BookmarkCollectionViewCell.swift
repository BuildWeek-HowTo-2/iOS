//
//  BookmarkCollectionViewCell.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

protocol DeleteBookmarkDelegate: AnyObject {
    func deleteBookmark(for cell: BookmarkCollectionViewCell)
}

class BookmarkCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var bookmarkButton: UIButton!
    @IBOutlet private weak var likesLabel: UILabel!
    
    weak var delegate: DeleteBookmarkDelegate?
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
        likesLabel.text = "\(tutorial.likes)"
    }
    
    // MARK: - IBActions
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        delegate?.deleteBookmark(for: self)
    }
    
}
