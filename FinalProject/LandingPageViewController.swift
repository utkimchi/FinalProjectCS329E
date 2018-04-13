//
//  LandingPageViewController.swift
//  FinalProject
//
//  Created by Avila, Colton C on 4/10/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit
import CoreData

class LandingPageViewController: UIViewController {
    
    // Labels
    @IBOutlet weak var homeTitle: UILabel!
    @IBOutlet weak var cardboardTitle: UILabel!
    @IBOutlet weak var glassTitle: UILabel!
    @IBOutlet weak var metalTitle: UILabel!
    @IBOutlet weak var paperTitle: UILabel!
    @IBOutlet weak var plasticTitle: UILabel!
    @IBOutlet weak var recyclingTitle: UILabel!
    @IBOutlet weak var garbageTitle: UILabel!
    @IBOutlet weak var cardboardValue: UILabel!
    @IBOutlet weak var glassValue: UILabel!
    @IBOutlet weak var metalValue: UILabel!
    @IBOutlet weak var paperValue: UILabel!
    @IBOutlet weak var plasticValue: UILabel!
    @IBOutlet weak var garbageValue: UILabel!
    @IBOutlet weak var recyclingValue: UILabel!
    
    
    // Buttons
    @IBAction func itemSelectorButton(_ sender: UIButton) {
    }
    @IBAction func friendsListButton(_ sender: Any) {
    }
    @IBAction func addFriendButton(_ sender: Any) {
    }
    
    // User entities and name variable
    var ownerInfoArr = [NSManagedObject]()
    var ownerInfo = NSManagedObject()
    var ownerName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Recycler")
        
        var fetchedResult: [NSManagedObject]? = nil
        
        // Sets fetchedResult NSManagedObject to user's Recycler entity
        do {
            try fetchedResult = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Sets the ownerInfoArr variable if fetchedResult has been created properly
        if let results = fetchedResult {
            ownerInfoArr = results
        } else {
            print("Could not fetch")
        }
        
        //Pulls the data from owner to Array
        ownerInfo = ownerInfoArr[0]
        
        // Sets the ownerName variable by pullling from the data in the ownerInfo variable
        ownerName = (ownerInfo.value(forKey: "name") as! String)
        
        // Set value labels to respective ownerInfo values
//        glassValue.text = (ownerInfo.value(forKey: "glassTotal") as! String)
//        cardboardValue.text = (ownerInfo.value(forKey: "cardboardTotal") as! String)
//        metalValue.text = (ownerInfo.value(forKey: "metalTotal") as! String)
//        paperValue.text = (ownerInfo.value(forKey: "paperTotal") as! String)
//        plasticValue.text = (ownerInfo.value(forKey: "plasticTotal") as! String)
        //recyclingValue.text = ((ownerInfo.value(forKey: "glassTotal") + ownerInfo.value(forKey: "cardboardTotal") + ownerInfo.value(forKey: "metalTotal") + ownerInfo.value(forKey: "paperTotal") + ownerInfo.value(forKey: "plasticTotal")) as! String)
        
        //FIREBASE
        //DataStore.shared.loadFriends(ownerName: ownerName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ItemSelector"{
            _ = segue.destination as? ItemSelectorView
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
        else if segue.identifier == "FriendsList"{
            _ = segue.destination as? FriendsListViewController
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
        else if segue.identifier == "AddFriend"{
            _ = segue.destination as? AddFriendViewController
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    //setting the screeentitle
    private func setScreenTitle() {
        self.title = "Welcome to Recyclops!"
    }

}
