//
//  AuthService.swift
//  LikeChat
//
//  Created by Heitem OULED-LAGHRIYEB on 10/30/17.
//  Copyright © 2017 Heitem OULED-LAGHRIYEB. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errorMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completion?) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    if errorCode == AuthErrorCode.userNotFound {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handleFirebaseError(errorMsg: error! as NSError, onComplete: onComplete)
                            } else {
                                if user?.uid != nil {
                                    DataService.instance.saveUser(uid: user!.uid)
                                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handleFirebaseError(errorMsg: error! as NSError, onComplete: onComplete)
                                        } else {
                                            onComplete?(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    } else {
                        self.handleFirebaseError(errorMsg: error! as NSError, onComplete: onComplete)
                    }
                } else {
                    onComplete?(nil, user)
                }
            }
        }
    }
    
    func handleFirebaseError(errorMsg: NSError, onComplete: Completion?) {
        print(errorMsg.debugDescription)
        if let errorCode = AuthErrorCode(rawValue: errorMsg.code) {
            switch (errorCode) {
            case .invalidEmail:
                onComplete?("Invalid email adress", nil)
            break
            case .wrongPassword:
                onComplete?("Invalid password", nil)
            break
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                onComplete?("Could not create email account. Email already in use.", nil)
            break
            default:
                onComplete?("There was a problem authenticating, try again.", nil)
            }
        }
    }
}
