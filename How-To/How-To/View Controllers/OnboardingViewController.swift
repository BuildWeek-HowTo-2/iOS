//
//  OnboardingViewController.swift
//  How-To
//
//  Created by Nichole Davidson on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var welcomeImage: UIImage!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeText: UITextView!
//    @IBOutlet weak var pageTwoImage: UIImage!
//    @IBOutlet weak var pageTwoLabel: UILabel!
//    @IBOutlet weak var pageTwoText: UITextView!
//    @IBOutlet weak var pageThreeImage: UIImage!
//    @IBOutlet weak var pageThreeLabel: UILabel!
//    @IBOutlet weak var pageThreeText: UITextView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        for image in 0...3 {
            let imageToDisplay = UIImage(named: "\(image).png")
            welcomeImage = imageToDisplay
            
            
            
        }
        
    }
    
    func updateViews() {
//        welcomeLabel.text = "Welcome to HowTo."
//        welcomeText.text = "The new world of community knowledge is here."
//        pageTwoLabel.text = "Discover"
//        pageTwoText.text = "Find tips and tricks to help with your home improvement needs."
//        pageThreeLabel.text = "Bookmark"
//        pageThreeText.text = "HowTo makes it easy to keep track of those hacks and home improvement instructionals with bookmarks."
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(414))
    }
    
    @IBAction func getStartedTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}
