//
//  User.swift
//  LikeChat
//
//  Created by Heitem OULED-LAGHRIYEB on 11/2/17.
//  Copyright © 2017 Heitem OULED-LAGHRIYEB. All rights reserved.
//

import UIKit

struct User {
    
    private var _firstName: String!
    private var _uid: String!
    
    var firstName: String {
        return _firstName
    }
    
    var uid: String {
        return _uid
    }
    
    init(firstName: String, uid: String) {
        _firstName = firstName
        _uid = uid
    }
}
