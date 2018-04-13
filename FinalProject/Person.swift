//
//  Person.swift
//  FinalProject
//
//  Created by Avila, Colton C on 4/10/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import Foundation

class Person {
    
    var cardBoardTotal: String
    var glassTotal: String
    var metalsTotal: String
    var paperTotal: String
    var plasticTotal: String
    var garbageTotal: String
    var username: String
    var password: String
    var city: String
    var state: String
    var gender: String
    var humanName: String
    var age: String
    var backgroundColor : String
    
    // Shouldn't this be a list?
    // var friendsList = [String]()
    var friendsList: String
    
    init(username: String, password: String, city: String, state: String, gender: String, humanName: String, age: String, friendsList: String) {
        self.cardBoardTotal = "0"
        self.glassTotal = "0"
        self.metalsTotal = "0"
        self.paperTotal = "0"
        self.plasticTotal = "0"
        self.garbageTotal = "0"
        self.username = username
        self.password = password
        self.city = city
        self.state = state
        self.gender = gender
        self.humanName = humanName
        self.age = age
        self.friendsList = friendsList
        self.backgroundColor = "white"
    }
}

