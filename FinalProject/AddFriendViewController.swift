//
//  AddFriendViewController.swift
//  FinalProject
//
//  Created by Xiao, Bryan on 4/12/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //setting the screeentitle
    private func setScreenTitle() {
        self.title = "Add Friend"
    }
}
