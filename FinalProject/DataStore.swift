//
//  DataStore.swift
//  FinalProject
//
//  Created by Avila, Colton C on 4/10/18.
//  Copyright © 2018 Group 12. All rights reserved.
//

import Foundation
import Firebase
import CoreData


class DataStore {

    // Instantiate the singleton object.
    static let shared = DataStore()

    private var ref: DatabaseReference!
    private var friends: [Person]!
    var ownerInfoArr = [NSManagedObject]()
    var ownerInfo = NSManagedObject()
    var ownerName:String = ""

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
    
    func getOwner(){
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
        
        // Sets the ownerName variable by pullling from the data in the ownerInfo variable
        ownerName = (ownerInfo.value(forKey: "name") as! String)
    }
    
    func loadFriends(ownerName:String) {
        // Start with an empty array.
        getOwner()
        print(ownerName)
        let currentFriendList = ownerInfo.value(forKey: "friendsList") as! [String]
        friends = [Person]()
        
        // Fetch the data from Firebase and store it in our internal people array.
        // This is a one-time listener.

        //For the owner's name you access the person array they have
        ref.child("people").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            if let persons = value{
                for p in persons{
                    for x in currentFriendList{
                        if p.key as! String == x{
                            print(p.key as! String)
                            print(x)
                            let username = p.key as! String
                            let person = p.value as! [String:Any]
                            let cardboardTotal = person["cardboardTotal"]
                            let glassTotal = person["glassTotal"]
                            let metalsTotal = person["metalsTotal"]
                            let paperTotal = person["paperTotal"]
                            let plasticTotal = person["plasticTotal"]
                            let garbageTotal = person["garbageTotal"]
                            let password = "fakePlaceholder"
                            let friendsList = [""]
                            let city = person["city"]
                            let state = person["state"]
                            let gender = person["gender"]
                            let humanName = person["humanName"]
                            let age = person["age"]
                            let backgroundColor = person["backgroundColor"]
                            
                            let newFriend = Person(cardBoardTotal: cardboardTotal as! String, glassTotal: glassTotal as! String, metalsTotal: metalsTotal as! String!, paperTotal: paperTotal as! String!, garbageTotal: garbageTotal as! String!, plasticTotal: plasticTotal as! String!, username: username as String!, password: password , city: city as! String, state: state as! String!, gender: gender as! String, humanName: humanName as! String, age: age as! String, friendsList: friendsList , backgroundColor: backgroundColor as! String)
                            self.friends.append(newFriend)
                        }
                        
                    }
                }
            }

        }) { (error) in
            print(error.localizedDescription)
        }
    }

    func addFriend(ownerName: String, friendsUsername: String) {
        // define array of key/value pairs to store for this person.
        let key = self.ref.child("people").child(ownerName).key
        let newFriend = ["friendsList" : friendsUsername]

        let friendUpdates = ["/people/\(ownerName)/\(key)/": newFriend]

        // Save to Firebase.
        ref.updateChildValues(friendUpdates)
        // Also save to our internal array, to stay in sync with what's in Firebase.
        //friends.append(person)
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
            "friendsList": person.friendsList,
            "city": person.city,
            "state": person.state,
            "gender": person.gender,
            "humanName": person.humanName,
            "age": person.age,
            "backgroundColor": person.backgroundColor
            ] as [String : Any]

        self.ref.child("people").child(person.username).setValue(userRecord)
    }
}




