//
//  SettingViewController.swift
//  FinalProject
//
//  Created by Anna Su on 4/12/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit
import CoreData

class SettingViewController: UIViewController {

    @IBOutlet weak var passwordvalue: UITextField!
    @IBOutlet weak var namevalue: UITextField!
    @IBOutlet weak var cityvalue: UITextField!
    @IBOutlet weak var statevalue: UITextField!
    @IBOutlet weak var humanNameSetting: UILabel!
    var alertController:UIAlertController? = nil
    
    //Notification button
    @IBOutlet weak var notification: UILabel!
    @IBAction func notificationswitch(_ sender: UISwitch) {
        
    if (sender.isOn == true) {
            notification.text = "On"
        } else {
            notification.text = "Off"
        }
    }
    
    //Profile Photo change
    @IBAction func photoChange(_ sender: UIButton) {
        
    }
    
    
    //background color change choosing
    let colors = [UIColor.red, UIColor.lightGray, UIColor.white]
    var indes = 0
    
    @IBAction func backgroundcolor(_ sender: UIButton) {
        self.view.backgroundColor = colors[indes]
        if indes == colors.count - 1 {
            indes = 0
        } else {
            indes += 1
        }
        //performSegue(withIdentifier: "profiletosetting", sender: self)
    }
    
    //before the segue, you take the data and throw it to whichever is next
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let profileViewController = segue.destination as! ProfileViewController
        profileViewController.colors = colors
        profileViewController.indes = indes
    }
    
    //set up the submit button
    @IBAction func submitsetting(_ sender: UIButton) {
        // Sends a pop-up alert if any of the fields are empty
        if passwordvalue.text == "" || namevalue.text == "" || cityvalue.text == "" || statevalue.text == "" {
            self.alertController = UIAlertController(title: "Error", message: "You must enter a value for all fields", preferredStyle: UIAlertControllerStyle.alert)
            
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            }
            self.alertController!.addAction(OKAction)
            
            self.present(self.alertController!, animated: true, completion:nil)
        
        //if the boxes are all filled
        } else {
            self.alertController = UIAlertController(title: "Update Information", message: "You are about to make changes to your profile", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let ok = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: { (action) -> Void in
                print("Confirm Button Pressed")
                
                ////update changes made to the profile
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                
                self.ownerInfo.setValue(self.passwordvalue.text, forKey: "password")
                self.self.ownerInfo.setValue(self.cityvalue.text, forKey: "city")
                self.ownerInfo.setValue(self.statevalue.text, forKey: "state")
                self.ownerInfo.setValue(self.namevalue.text, forKey: "humanName")
                
                // Commit the changes.
                do {
                    try managedContext.save()
                } catch {
                    // what to do if an error occurs?
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            })
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
                print("Cancel Button Pressed")
            })
            
            self.alertController!.addAction(ok)
            self.alertController!.addAction(cancel)
            
            present(self.alertController!, animated: true, completion: nil)
            
        }
    }
    
    //load and update the core data - set info
    var ownerInfoArr = [NSManagedObject]()
    var ownerInfo = NSManagedObject()
    
    //Pulls Owner's Name from CoreData
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        //Pulls the data from owner to Array
        ownerInfo = ownerInfoArr[0]
        
        //automatically generate user profile information to fillin the textbox
        let dummyPassword = (ownerInfo.value(forKey: "password") as! String)
        passwordvalue.text = dummyPassword
        let dummyName = (ownerInfo.value(forKey: "humanName") as! String)
        namevalue.text = dummyName
        let dummyCity = (ownerInfo.value(forKey: "city") as! String)
        cityvalue.text = dummyCity
        let dummyState = (ownerInfo.value(forKey: "state") as! String)
        statevalue.text = dummyState
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle()
        // Do any additional setup after loading the view.
    }

    //setting the screeentitle
    private func setScreenTitle() {
        self.title = "Settings"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
