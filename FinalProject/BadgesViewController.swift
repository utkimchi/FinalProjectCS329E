//
//  BadgesViewController.swift
//  FinalProject
//
//  Created by Xiao, Bryan on 4/21/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BadgesViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    //load and update the core data - set info
    var ownerInfoArr = [NSManagedObject]()
    var ownerInfo = NSManagedObject()
    
    // data source for table view
    var tableViewData = [String]()
    
    // Initial setups
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle()
        // Do any additional setup after loading the view.
        textView.textDragDelegate = self
        tableView.dropDelegate = self
        tableView.dataSource = self
    }
    
    // setting the screentitle
    private func setScreenTitle() {
        self.title = "Badges"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action handler for saveBadgesBtn
    @IBAction func saveBadgesBtn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Recycler")
        
        //
        var fetchedResult: [NSManagedObject]? = nil
        
        do {
            try fetchedResult = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResult {
            ownerInfoArr = results
        } else {
            print("Could not fetch")
        }
        
        ownerInfo = ownerInfoArr[0]
        
        self.ownerInfo.setValue(["badge1"], forKey: "badges")
        print("setvalue working")
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }

    }

}

extension BadgesViewController:UITextDragDelegate, UITableViewDropDelegate{
    
    // sets image for drag event
    func textDraggableView(_ textDraggableView: UIView & UITextDraggable, dragPreviewForLiftingItem item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        
        // creates image view for drag event
        let imageView = UIImageView(image: UIImage(named:"smiley-face"))
        imageView.backgroundColor = UIColor.red
        
        let dragView = textDraggableView
        // where drag originates from
        let dragPoint = session.location(in: dragView)
        // drag preview target
        let target = UIDragPreviewTarget(container: dragView, center: dragPoint)
        
        return UITargetedDragPreview(view: imageView, parameters: UIDragPreviewParameters(), target: target)
        
    }
    
    // sets the value of the dragged object
    func textDraggableView(_ textDraggableView: UIView & UITextDraggable, itemsForDrag dragRequest: UITextDragRequest) -> [UIDragItem] {
        
        // 'string' is set to whatever text is being dragged
        if let string = textView.text(in: dragRequest.dragRange){
            let itemProvider = NSItemProvider(object: string as NSString)
            return [UIDragItem(itemProvider: itemProvider)]
        }
        else
        {
            return []
        }
        
    }
    
    // handles when dragged object is dropped
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        let destIndexPath:IndexPath
        
        // sets the destinationIndexPath depending on where the dragged item is dropped
        if let indexPath = coordinator.destinationIndexPath {
            destIndexPath = indexPath
        }
        else{
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destIndexPath = IndexPath(row: row, section: section)
        }
        
        // inserts the text set from the function above into the tableViewData
        coordinator.session.loadObjects(ofClass: NSString.self)
        {items in
            guard let stringsArray = items as? [String] else {return}
            
            self.tableViewData.insert(stringsArray.first!, at: destIndexPath.row)
            
            tableView.insertRows(at: [destIndexPath], with: .automatic)
            
        }
        
    }
}

// Configure the Table View
extension BadgesViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let stringObject = tableViewData[indexPath.row]
        
        cell.textLabel?.text = stringObject
        
        return cell
    }
}
