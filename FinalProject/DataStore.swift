//
//  DataStore.swift
//  FinalProject
//
//  Created by Avila, Colton C on 4/10/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import Foundation
import Firebase

class DataStore {
    
    // Instantiate the singleton object.
    static let shared = DataStore()
    
    private var ref: DatabaseReference!
    private var friends: [Person]!
    
    // Making the init method private means only this class can instantiate an object of this type.
    private init() {
        // Get a database reference.
        // Needed before we can read/write to/from the firebase database.
        ref = Database.database().reference()
        
    }
    
    func count() -> Int {
        return friends.count
    }
    
    func getPerson(index: Int) -> Person {
        return friends[index]
    }
    
    func loadFriends(ownerName:String) {
        // Start with an empty array.
        var tryFriends = [Person]()
        
        // Fetch the data from Firebase and store it in our internal people array.
        // This is a one-time listener.
        
        //For the owner's name you access the person array they have
        ref.child("people").child(ownerName).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            tryFriends = (value?["friendsList"] as? [Person])!
            self.friends = tryFriends
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addFriend(ownerName: String, friendsUsername: String) {
        // define array of key/value pairs to store for this person.
        let key = ref.child("people").child(ownerName).key
        let newFriend = ["friendsList" : friendsUsername]
        
        let friendUpdates = ["/people/\(ownerName)/\(key)/": newFriend]
        
        // Save to Firebase.
        ref.updateChildValues(friendUpdates)
        // Also save to our internal array, to stay in sync with what's in Firebase.
    }
    
    func addUser(person: Person)
    {
        let userRecord = [
            "cardboardTotal":person.cardBoardTotal,
            "glassTotal": person.glassTotal,
            "metalsTotal": person.metalsTotal,
            "paperTotal": person.paperTotal,
            "plasticTotal": person.plasticTotal,
            "garbageTotal": person.garbageTotal,
            "password": person.password,
            "friendsList": person.friendsList
            ]
        
        self.ref.child("people").child(person.username).setValue(userRecord)
    }
}



