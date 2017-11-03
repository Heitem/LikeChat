//
//  UsersVC.swift
//  LikeChat
//
//  Created by Heitem OULED-LAGHRIYEB on 11/2/17.
//  Copyright © 2017 Heitem OULED-LAGHRIYEB. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    
    private var _snapData: Data?
    private var _videoUrl: URL?
    
    var snapData: Data? {
        get {
            return _snapData
        }
        set {
            _snapData = newValue
        }
    }
    
    var videoUrl: URL? {
        get {
            return _videoUrl
        }
        set {
            _videoUrl = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.userRef.observeSingleEvent(of: .value) { (snapshot) in
            print("Heitem: \(snapshot.debugDescription)")
            
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, AnyObject> {
                        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let user = User(firstName: firstName, uid: uid)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
            print("Heitem: user : \(self.users)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    @IBAction func sendPRBtnTapped(_ sender: Any) {
        if let url = _videoUrl {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videosStorageRef.child(videoName)
            _ = ref.putFile(from: url, metadata: nil, completion: { (meta, error) in
                if error != nil {
                    print("Error uploading video: \(error.debugDescription)")
                } else {
                    let downloadUrl = meta?.downloadURL()
                    DataService.instance.sendMediaPullRequest(senderUID: Auth.auth().currentUser!.uid, sendingTo: self.selectedUsers, mediaUrl: downloadUrl!, textSnippet: "Coding today as LEGIT!")
                }
            })
            self.dismiss(animated: true, completion: nil)
        } else if let snap = _snapData {
            let ref = DataService.instance.imagesStorageRef.child("\(NSUUID().uuidString).jpg")
            _ = ref.putData(snap, metadata: nil, completion: { (meta, error) in
                if error != nil {
                    print("Error uploading images: \(error.debugDescription)")
                } else {
                    let downloadUrl = meta?.downloadURL()
                    DataService.instance.sendMediaPullRequest(senderUID: Auth.auth().currentUser!.uid, sendingTo: self.selectedUsers, mediaUrl: downloadUrl!, textSnippet: "Coding today as LEGIT!")
                }
            })
            self.dismiss(animated: true, completion: nil)
        }
    }
}
