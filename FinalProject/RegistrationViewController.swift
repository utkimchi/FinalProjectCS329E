//
//  RegistrationViewController.swift
//  FinalProject
//
//  Created by Avila, Colton C on 4/3/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameTField: UITextField!
    @IBOutlet weak var passwordTField: UITextField!
    var alertController:UIAlertController? = nil
    var entityExists = false
    @IBOutlet weak var successLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.usernameTField.delegate = self
        self.passwordTField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Keyobard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveUserInfo(_ sender: UIButton) {
        if usernameTField.text == "" || passwordTField.text == ""{
            self.alertController = UIAlertController(title: "Error", message: "You must enter a value for all fields", preferredStyle: UIAlertControllerStyle.alert)
            
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            }
            self.alertController!.addAction(OKAction)
            
            self.present(self.alertController!, animated: true, completion:nil)
        }
            //Create recycler
        else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            // Create the entity we want to save
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Recycler")
            print("Check1")
            do{
                let check = try managedContext.fetch(fetchRequest)
                print(check.count)
                if check.count == 1
                {
                    print("Heyo! I'm overwritten")
                    let recycler = check[0] as! NSManagedObject
                    recycler.setValue(0, forKey: "cardboardTotal")
                    recycler.setValue(0, forKey: "glassTotal")
                    recycler.setValue(0, forKey: "metalsTotal")
                    recycler.setValue(0, forKey: "paperTotal")
                    recycler.setValue(0, forKey: "plasticTotal")
                    recycler.setValue(0, forKey: "pureGarbageTotal")
                    recycler.setValue(usernameTField.text, forKey: "name")
                    recycler.setValue(passwordTField.text, forKey: "password")
                    entityExists = true
                    do {
                        try managedContext.save()
                    } catch {
                        // what to do if an error occurs?
                        let nserror = error as NSError
                        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                        abort()
                    }
                    
                    successLabel.text = ("Welcome \(recycler.value(forKey: "name") as! String)!")
                }
            }
            catch
            {
                print(error)
            }
                
            if entityExists == false{
                let entity =  NSEntityDescription.entity(forEntityName: "Recycler", in: managedContext)
                
                let recycler = NSManagedObject(entity: entity!, insertInto:managedContext)
                
                recycler.setValue(0, forKey: "cardboardTotal")
                recycler.setValue(0, forKey: "glassTotal")
                recycler.setValue(0, forKey: "metalsTotal")
                recycler.setValue(0, forKey: "paperTotal")
                recycler.setValue(0, forKey: "plasticTotal")
                recycler.setValue(0, forKey: "pureGarbageTotal")
                recycler.setValue(usernameTField.text, forKey: "name")
                recycler.setValue(passwordTField.text, forKey: "password")
                
                // Commit the changes.
                do {
                    try managedContext.save()
                } catch {
                    // what to do if an error occurs?
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
                
                successLabel.text = ("Welcome \(recycler.value(forKey: "name") as! String)!")
            }
            
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
