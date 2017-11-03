//
//  CameraVCDelegate.swift
//  LikeChat
//
//  Created by Heitem OULED-LAGHRIYEB on 10/24/17.
//  Copyright © 2017 Heitem OULED-LAGHRIYEB. All rights reserved.
//

import Foundation

protocol CameraVCDelegate {
    func shouldEnableRecordUI(enable: Bool)
    func shouldEnableCameraUI(enable: Bool)
    func canStartRecording()
    func recordingHasStarted()
    func videoRecordingComplete(videoUrl: NSURL)
    func videoRecordingFailed()
    func snapshotTaken(snapshotData: NSData)
    func snapshotFailed()
}
