//
//  Challenge.swift
//  Challenger
//
//  Created by Dune Zerna on 11/12/2019.
//  Copyright © 2019 University of Southern Denmark. All rights reserved.
//

import Foundation

// Dune: Challenge.swift holds members for all challenges
class Challenge {
    
        // Dune: Predefined challenge array
        static var predefinedChallenges = [" ","5000","10000", "20000"]
        static var challenges: [String] = []
    
        // Dune: Predefined descriptions
        static var description: [String] = [" ","Running is good for you. Let's try to run for 5KM", "Walking is essential to reduce cardiac arrests and other health issues. Let's try to walk 10.000 steps", "Well, walking backwards can be a challenge"]
    
        // Dune: Array for saved challenges, persists through sessions
    static var savedChallenges: [String] = UserDefaults.standard.stringArray(forKey: "savedChallenges") ?? [""]
    // Dune: Array for saved descriptions, persists through sessions
    static var savedDescriptions: [String] = UserDefaults.standard.stringArray(forKey: "savedDescriptions") ?? [""]
        static var totalSteps: String = ""
    
    //Pernille: declared array of activeChallenges - this is set based on the steps registered on device vs the Challenge goal. If steps walked are less than Challenge goal, they're on the active list
    static var activeChallenges: [String] = UserDefaults.standard.stringArray(forKey: "savedActiveChallenges") ?? [""]

}
