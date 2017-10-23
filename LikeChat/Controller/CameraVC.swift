//
//  ViewController.swift
//  LikeChat
//
//  Created by Heitem OULED-LAGHRIYEB on 10/23/17.
//  Copyright © 2017 Heitem OULED-LAGHRIYEB. All rights reserved.
//

import UIKit

class CameraVC: CameraViewController {

    @IBOutlet weak var previewView: PreviewView!
    
    override func viewDidLoad() {
        self._previewView = previewView
        super.viewDidLoad()
        
    }
    
    @IBAction func recordBtnTapped(_ sender: Any) {
        self.toggleMovieRecording(sender as! UIButton)
    }
    
    @IBAction func changeCameraBtnTapped(_ sender: Any) {
        self.changeCamera(sender as! UIButton)
    }
    
}

