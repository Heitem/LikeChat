//
//  ViewController.swift
//  LikeChat
//
//  Created by Heitem OULED-LAGHRIYEB on 10/23/17.
//  Copyright © 2017 Heitem OULED-LAGHRIYEB. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: CameraViewController, CameraVCDelegate {
    
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    
    func shouldEnableRecordUI(enable: Bool) {
        recordBtn.isEnabled = enable
        print("Should enable record UI : \(enable)")
    }
    
    func shouldEnableCameraUI(enable: Bool) {
        cameraBtn.isEnabled = enable
        print("Should enable camera UI : \(enable)")
    }
    
    func canStartRecording() {
        print("Recording has started")
    }
    
    func recordingHasStarted() {
        print("Can start recording")
    }
    
    func videoRecordingComplete(videoUrl: NSURL) {
        performSegue(withIdentifier: "UsersVC", sender: ["videoUrl": videoUrl])
    }
    
    func videoRecordingFailed() {
        
    }
    
    func snapshotTaken(snapshotData: NSData) {
        performSegue(withIdentifier: "UsersVC", sender: ["snapshotData": snapshotData])
    }
    
    func snapshotFailed() {
        
    }

    @IBOutlet weak var previewView: PreviewView!
    
    override func viewDidLoad() {
        self._previewView = previewView
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard Auth.auth().currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
    }
    
    @IBAction func recordBtnTapped(_ sender: Any) {
        self.toggleMovieRecording(sender as! UIButton)
    }
    
    @IBAction func changeCameraBtnTapped(_ sender: Any) {
        self.changeCamera(sender as! UIButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let usersVC = segue.destination as? UsersVC {
            if let videoDict = sender as? Dictionary<String, URL> {
                let url = videoDict["videoUrl"]
                usersVC.videoUrl = url
            } else if let snapDict = sender as? Dictionary<String, Data> {
                let snapData = snapDict["snapshotData"]
                usersVC.snapData = snapData
            }
        }
    }
    
}

