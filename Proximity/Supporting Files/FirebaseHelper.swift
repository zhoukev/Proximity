//
//  RESTHelper.swift
//  Proximity
//
//  Created by Kevin Zhou on 11/5/17.
//  Copyright © 2017 Kevin Zhou. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import GooglePlaces
import GoogleMaps

class FirebaseHelper{
    static var personalRegion = CGPoint(x:-1,y:-1)
    static var personal:Personal!
    static var nearbyProfiles = NSMutableArray()
    static var ref = Database.database().reference()
    static var placesClient = GMSPlacesClient()
    static var storageRef = Storage.storage().reference()
    static func updatePersonal(){
        
        let usersRef = ref.child("users").child(personal.userId)
        let userValues = ["username":personal.username,"email":personal.email,"icon":personal.icon,"latitude":personal.latitude,"longitude":personal.longitude] as [String : Any]
        usersRef.updateChildValues(userValues, withCompletionBlock: { (err, ref) in
            if err != nil{
                print(err)
                return
            }
        })
        for var i in 0..<personal.friends.count{
            let value = ["\(i)":(personal.friends[i] as! Profile).userId]
            usersRef.child("friends").updateChildValues(value)
        }
        for var i in 0..<personal.friendRequests.count{
            let value = ["\(i)":(personal.friendRequests[i] as! Profile).userId]
            usersRef.child("friendRequests").updateChildValues(value)
        }
        for var i in 0..<personal.chats.count{
            let value = ["\(i)":(personal.chats[i] as! Chat).id]
            usersRef.child("chats").updateChildValues(value)
        }
    }
}
