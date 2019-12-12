//
//  UserModel.swift
//  Challenger
//
//  Created by Dune Zerna on 04/12/2019.
//  Copyright © 2019 University of Southern Denmark. All rights reserved.
//

import Foundation


// Dune: User information
struct userProfile {
    
    static let username = UserDefaults.standard.string(forKey: "username")
    static let password = UserDefaults.standard.string(forKey: "password")
    static let firstName = UserDefaults.standard.string(forKey: "firstName")
    static let lastName = UserDefaults.standard.string(forKey: "lastName")
    enum gender: String {
        case man
        case woman
        case other
        
        func returnGender() -> String {
            return self.rawValue
        }
    }

}
