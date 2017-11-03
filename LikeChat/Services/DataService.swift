//
//  DataService.swift
//  LikeChat
//
//  Created by Heitem OULED-LAGHRIYEB on 10/31/17.
//  Copyright © 2017 Heitem OULED-LAGHRIYEB. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

let FIR_CHILD_USERS = "users"

class DataService {
    
    private static var _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var mainStorageRef: StorageReference {
        return Storage.storage().reference()
    }
    
    var userRef: DatabaseReference {
        return mainRef.child(FIR_CHILD_USERS)
    }
    
    var imagesStorageRef: StorageReference {
        return mainStorageRef.child("images")
    }
    
    var videosStorageRef: StorageReference {
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, AnyObject> = ["firstname": "" as AnyObject, "lastname": "" as AnyObject]
        mainRef.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
    }
    
    func sendMediaPullRequest(senderUID: String, sendingTo: Dictionary<String, User>, mediaUrl: URL, textSnippet: String? = nil) {
        var uids = [String]()
        for uid in sendingTo.keys {
            uids.append(uid)
        }
        let pr: Dictionary<String, AnyObject> = ["mediaUrl": mediaUrl.absoluteString as AnyObject, "userID": senderUID as AnyObject, "openCount": 0 as AnyObject, "recipients": uids as AnyObject]
        mainRef.child("pullRequests").childByAutoId().setValue(pr)
    }
}
