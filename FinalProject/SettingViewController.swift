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

    @IBOutlet weak var usernamevalue: UITextField!
    @IBOutlet weak var passwordvalue: UITextField!
    @IBOutlet weak var namevalue: UITextField!
    @IBOutlet weak var cityvalue: UITextField!
    @IBOutlet weak var statevalue: UITextField!
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
    
    //background color change choosing
    let colors = [UIColor.red, UIColor.lightGray, UIColor.magenta]
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
    
    @IBAction func submitsetting(_ sender: UIButton) {
        // Sends a pop-up alert if any of the fields are empty
        if usernamevalue.text == "" || passwordvalue.text == "" || namevalue.text == "" || cityvalue.text == "" || statevalue.text == "" {
            self.alertController = UIAlertController(title: "Error", message: "You must enter a value for all fields", preferredStyle: UIAlertControllerStyle.alert)
            
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            }
            self.alertController!.addAction(OKAction)
            
            self.present(self.alertController!, animated: true, completion:nil)
        }
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
