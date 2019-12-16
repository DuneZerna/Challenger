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
    static let userGender = UserDefaults.standard.string(forKey: "gender")
    enum gender: String {
        case man
        case woman
        case other
        
        func returnGender() -> String {
            return self.rawValue
        }
        
    }
    
    // Dune: Method for saving user info
    static func saveInfo(username: String, password: String, firstName: String, lastName: String, gender: String){
        let saveUsername = username
        let savePassword = password
        let saveFirstName = firstName
        let saveLastName = lastName
        let saveGender = gender
        UserDefaults.standard.set(saveUsername, forKey: "username")
        UserDefaults.standard.set(savePassword, forKey: "password")
        UserDefaults.standard.set(saveFirstName, forKey: "firstName")
        UserDefaults.standard.set(saveLastName, forKey: "lastName")
        UserDefaults.standard.set(saveGender, forKey: "gender")
        
        func getInfo() -> (String, String, String, String, String){
            return (saveUsername, savePassword, saveFirstName, saveLastName, saveGender)
        }
    }

}
