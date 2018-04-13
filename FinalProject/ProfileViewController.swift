//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by Anna Su on 4/12/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var colors = [UIColor.white]
    var indes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenTitle()
        self.view.backgroundColor = colors[indes]
        // Do any additional setup after loading the view.
    }
    
    //setting the screeentitle
    private func setScreenTitle() {
        self.title = "Profile"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
