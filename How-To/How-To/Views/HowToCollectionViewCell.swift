//
//  HowToCollectionViewCell.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

protocol HowToCellDelegate: class {
    func addBookmark(for cell: HowToCollectionViewCell)
    func likeTutorial(for cell: HowToCollectionViewCell)
}

class HowToCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: HowToCellDelegate?
     var tutorial: Tutorial? {
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
        delegate?.addBookmark(for: self)
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        delegate?.likeTutorial(for: self)
    }
}
