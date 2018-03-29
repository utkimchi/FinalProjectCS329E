//
//  SignInViewController.swift
//  FinalProject
//
//  Created by Anna Su on 3/27/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth
import FacebookCore
import FacebookLogin

class SignInViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate, LoginButtonDelegate {
    
    @IBOutlet weak var loginTextfield: UITextField!
    var alertController:UIAlertController? = nil
    
    // Not called when alert is dismissed.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //Keyobard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Normal Login
    @IBAction func loginButton(_ sender: UIButton) {
        if loginTextfield.text == ""{
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
            let entity =  NSEntityDescription.entity(forEntityName: "Recycler", in: managedContext)
            
            let recycler = NSManagedObject(entity: entity!, insertInto:managedContext)
            
            recycler.setValue(0, forKey: "cardboardTotal")
            recycler.setValue(0, forKey: "glassTotal")
            recycler.setValue(0, forKey: "metalsTotal")
            recycler.setValue(0, forKey: "paperTotal")
            recycler.setValue(0, forKey: "plasticTotal")
            recycler.setValue(0, forKey: "pureGarbageTotal")
            recycler.setValue(loginTextfield.text, forKey: "name")
            
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
    
    
    
    //Facebook Login
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .success:
            let accessToken = AccessToken.current
            guard let accessTokenString = accessToken?.authenticationToken else {return}
            
            let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString); Auth.auth().signIn(with: credentials, completion: { (user, error) in
                    if error != nil {
                        print("Something went wrong: \(error?.localizedDescription)")
                    return
                }
                self.performSegue(withIdentifier: "loggedIn", sender: self)
            })
        //don't do anything
        default:
            break
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        //not doing any logout button
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Login
        self.loginTextfield.delegate = self
        
        //set the Google ui delegate
        GIDSignIn.sharedInstance().uiDelegate = self
    
        //store your login information
        //GIDSignIn.sharedInstance().signInSilently()

        let FBLoginBtn = LoginButton(readPermissions: [.publicProfile])
        FBLoginBtn.frame = CGRect(x: 100, y:550, width: view.frame.width - 200, height: 37)
        view.addSubview(FBLoginBtn)
        
        FBLoginBtn.delegate = self as? LoginButtonDelegate
        
        //BELOW ARE ALL OLD Facebook login button
        //let loginButton = FBSDKLoginButton()
        //view.addSubview(loginButton)
        
        //frames are obsolete use constraints if you want...LOL
        //loginButton.frame(forAlignmentRect: CGRect(x:16, y:50, width: view.frame.width - 32, height: 50))
        //loginButton.delegate = self
    //}
    
    //change button to logout
    //func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //print("Did log out of Facebook")
    //}
    
    //func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //if error != nil {
        //    print(error)
        //    return
        //}
        //print("Successfully logged in with Facebook.")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ItemCollector"{
            _ = segue.destination as? ItemSelectorView
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
    }
}



