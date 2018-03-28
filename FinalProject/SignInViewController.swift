//
//  SignInViewController.swift
//  FinalProject
//
//  Created by Anna Su on 3/27/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookCore
import FacebookLogin

class SignInViewController: UIViewController, GIDSignInUIDelegate, LoginButtonDelegate {
    
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
}
