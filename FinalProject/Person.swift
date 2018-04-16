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
    var friendsList = [String]()
    
    init(cardBoardTotal: String, glassTotal: String, metalsTotal: String, paperTotal: String, garbageTotal: String, plasticTotal: String, username: String, password: String, city: String, state: String, gender: String, humanName: String, age: String, friendsList : [String], backgroundColor: String) {
        self.cardBoardTotal = cardBoardTotal
        self.glassTotal = glassTotal
        self.metalsTotal = metalsTotal
        self.paperTotal = paperTotal
        self.plasticTotal = plasticTotal
        self.garbageTotal = garbageTotal
        self.username = username
        self.password = password
        self.city = city
        self.state = state
        self.gender = gender
        self.humanName = humanName
        self.friendsList = friendsList
        self.age = age
        self.backgroundColor = backgroundColor
    }
}

