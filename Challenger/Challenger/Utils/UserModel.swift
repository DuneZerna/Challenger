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
    
    static let username = ""
    static let password = ""
    
    func saveInfo(username: String, password: String){
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
        
    }
}

struct userChallenges {
    
    static let predefinedChallenges = [" ","Run 5KM","Walk 10K steps","Sleep 8 hours"]
    static let challenges: [String] = []
    static let description: [String] = [" ","Running is good for you. Let's try to run for 5KM"]
    
}
