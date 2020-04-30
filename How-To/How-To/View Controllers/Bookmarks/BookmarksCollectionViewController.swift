//
//  BookmarksCollectionViewController.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit
import CoreData

class BookmarksCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    var blockOperations: [BlockOperation] = []
    
    lazy var fetchedResultsController: NSFetchedResultsController<Guide> = {
        let fetchRequest: NSFetchRequest<Guide> = Guide.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "likes", ascending: true),
                                        NSSortDescriptor(key: "title", ascending: true)]
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "likes", cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            NSLog("Error fetching \(error)")
        }
        return frc
    }()

    deinit {
        for operation: BlockOperation in blockOperations {
            operation.cancel()
        }
        
        blockOperations.removeAll(keepingCapacity: false)
    }

}

extension BookmarksCollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        fetchedResultsController.sections?.count ?? 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookmarkCell", for: indexPath) as? BookmarkCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        cell.tutorial = fetchedResultsController.object(at: indexPath)
        cell.delegate = self
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
        CGSize(width: self.view.frame.width - 16, height: 100)
    }
}

extension BookmarksCollectionViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
    
        if type == NSFetchedResultsChangeType.insert {
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.insertItems(at: [newIndexPath!])
                    }
                    })
            )
        } else if type == NSFetchedResultsChangeType.update {
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadItems(at: [indexPath!])
                    }
                    })
            )
        } else if type == NSFetchedResultsChangeType.move {
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.moveItem(at: indexPath!, to: newIndexPath!)
                    }
                    })
            )
        } else if type == NSFetchedResultsChangeType.delete {
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.deleteItems(at: [indexPath!])
                    }
                    })
            )
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                           didChange sectionInfo: NSFetchedResultsSectionInfo,
                           atSectionIndex sectionIndex: Int,
                           for type: NSFetchedResultsChangeType) {
        if type == NSFetchedResultsChangeType.insert {
            print("Insert Section: \(sectionIndex)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.insertSections(NSIndexSet(index: sectionIndex) as IndexSet)
                    }
                    })
            )
        } else if type == NSFetchedResultsChangeType.update {
            print("Update Section: \(sectionIndex)")
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet)
                    }
                })
            )
        } else if type == NSFetchedResultsChangeType.delete {
            print("Delete Section: \(sectionIndex)")
            
            blockOperations.append(
                BlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet)
                    }
                    })
            )
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView!.performBatchUpdates({ () -> Void in
            for operation: BlockOperation in self.blockOperations {
                operation.start()
            }
            }, completion: { _ -> Void in
                self.blockOperations.removeAll(keepingCapacity: false)
        })
    }
}

extension BookmarksCollectionViewController: DeleteBookmarkDelegate {
    func deleteBookmark(for cell: BookmarkCollectionViewCell) {
        guard let bookmark = cell.tutorial else { return }
        
        let alert = UIAlertController(title: "Remove Bookmark",
                                      message: "Are you sure you want to remove this How-To tutorial from your bookmarks?",
                                      preferredStyle: .actionSheet)
        let addBookmarkAction = UIAlertAction(title: "Remove Bookmark", style: .destructive) { _ in
            let context = CoreDataStack.shared.mainContext
            context.delete(bookmark)
            
            do {
                try CoreDataStack.shared.save()
            } catch {
                context.reset()
                NSLog("Error saving managed object context (deleting record): \(error)")
            }
            self.collectionView.reloadData()
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addBookmarkAction)
        alert.addAction(dismissAction)
        present(alert, animated: true)
    }
}
