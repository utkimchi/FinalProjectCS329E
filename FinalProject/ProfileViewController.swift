//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by Anna Su on 4/12/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var ageValue: UILabel!
    @IBOutlet weak var cityValue: UILabel!
    @IBOutlet weak var genderValue: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var badgeViewOne: UIImageView!
    @IBOutlet weak var badgeViewTwo: UIImageView!
    @IBOutlet weak var badgeViewThree: UIImageView!
    @IBOutlet weak var badgeViewFour: UIImageView!
    @IBOutlet weak var badgeLabelOne: UILabel!
    @IBOutlet weak var badgeLabelTwo: UILabel!
    @IBOutlet weak var badgeLabelThree: UILabel!
    @IBOutlet weak var badgeLabelFour: UILabel!
    
    //background colors
    let colors = [UIColor.white, UIColor(red: 255/255, green: 253/255, blue: 198/255, alpha: 1),  UIColor(red: 255/255, green: 219/255, blue: 207/255, alpha: 1),  UIColor(red: 247/255, green: 220/255, blue: 255/255, alpha: 1), UIColor(red: 218/255, green: 227/255, blue: 255/255, alpha: 1), UIColor(red: 196/255, green: 255/255, blue: 194/255, alpha: 1), UIColor.lightGray]
    var indes = 0
    
    //User entities and name variable
    var ownerInfoArr = [NSManagedObject]()
    var ownerInfo = NSManagedObject()
    var ownerName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle()
        self.view.backgroundColor = colors[indes]
        // Do any additional setup after loading the view.
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
    }
    
    //setting the screeentitle
    private func setScreenTitle() {
        self.title = "Profile"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //fetch the coreData for now
    override func viewWillAppear(_ animated: Bool) {
        
        // Sets the ownerName variable by pullling from the data in the ownerInfo variable
        ownerName = (ownerInfo.value(forKey: "name") as! String)
        
        // Set value labels to respective ownerInfo values
        if let profilename = ownerInfo.value(forKey: "humanName") as? String{
            nameValue.text = profilename
        }
        if let profileage = ownerInfo.value(forKey: "age") as? String{
            ageValue.text = profileage
        }
        if let profilecity = ownerInfo.value(forKey: "city") as? String{
            let profilestate = ownerInfo.value(forKey: "state") as? String
            cityValue.text = profilecity + ", " + profilestate!
        }
        if let profilegender = ownerInfo.value(forKey: "gender") as? String{
            genderValue.text = profilegender
        }
        
        // set badge images
        let list = ownerInfo.value(forKey: "badges") as! [String]
        var count = 0
        if(list.count > 0){
        print(list[count])
        while(count < list.count){
                print(list[count])
                switch list[count]{
                case "Plastic Badge":
                    if(count == 0){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 1){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 2){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 3){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                case "Metal Badge":
                    if(count == 0){
                        badgeViewOne.image = UIImage(named: "smiley-face")
                    }
                    else if(count == 1){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 2){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 3){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }            case "Paper Badge":
                        badgeViewOne.image = UIImage(named: "badge1")
                case "Cardboard Badge":
                    if(count == 0){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 1){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 2){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 3){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                case "Glass Badge":
                    if(count == 0){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 1){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 2){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 3){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                case "Savior of the World":
                    if(count == 0){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 1){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 2){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 3){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                default:
                    if(count == 0){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 1){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 2){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                    else if(count == 3){
                        badgeViewOne.image = UIImage(named: "badge1")
                    }
                }
                count = count + 1;
            }
        }
        
        //set background color
        let background = ownerInfo.value(forKey: "backgroundColor") as? Int
        indes = background!
        self.view.backgroundColor = colors[indes]
    }
    
    //make sure the back button displays correctly
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SettingPage"{
            _ = segue.destination as? SettingViewController
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
    }
}


