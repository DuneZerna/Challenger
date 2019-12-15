//
//  Extensions.swift
//  Challenger
//
//  Created by Dune Zerna on 15/11/2019.
//  Copyright © 2019 University of Southern Denmark. All rights reserved.
//

import UIKit

extension DispatchQueue {

    private static var tokens: [String] = [] // static, so tokens are cached

    class func once(executionToken: String, _ closure: () -> Void) {
        // objc_sync_enter/objc_sync_exit is a locking mechanism
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        // if we previously stored token then do nothing
        if tokens.contains(executionToken) { return }
        tokens.append(executionToken)
        closure()
    }
}

// Dune: Email validation
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}


extension UIViewController {
    
    // Dune: Method for dismissing keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Dune: Method for user alerts
    func displayMessage(userMessage: String) -> Void {
            DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Caution", message: userMessage, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) {
                    (action: UIAlertAction!) in print("Alert message tapped")
                    
                    DispatchQueue.main.async
                        {
                       self.dismiss(animated: true, completion: nil)
                    }
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    
    // Dune: Method for saving new challenges
    func saveChallenge(newChallenge: String) -> Void{
        Challenge.savedChallenges.append(newChallenge)
        UserDefaults.standard.set(Challenge.savedChallenges, forKey: "savedChallenges")
    }
    
    // Dune: Method for saving new descriptions
    func saveDescription(newDescription: String) -> Void{
        Challenge.savedDescriptions.append(newDescription)
        UserDefaults.standard.set(Challenge.savedDescriptions, forKey: "savedDescriptions")
    }
    
    // Dune: Method for saving active challenges
    func saveActiveChallenge(activeChallenge: String) -> Void{
        Challenge.activeChallenges.append(activeChallenge)
        UserDefaults.standard.set(Challenge.activeChallenges, forKey: "savedActiveChallenges")
    }
    
    // Dune: Method for saving images
    func saveImage(imageFile: UIImage, fileName: String) -> Void {
        let dataFile = imageFile.pngData()
        UserDefaults().set(dataFile, forKey: fileName)
    }
    
    // Dune: Method for retrieving images
    func getImage(fileName: String) -> Data {
        let imageFile = UserDefaults.standard.object(forKey: fileName) as! Data
        return imageFile
    }
    
    // Dune: Method for saving user info
    func saveInfo(username: String, password: String, firstName: String, lastName: String, gender: String){
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


// Dune: Layout color method
extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(displayP3Red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}

// Dune: Layout border method
extension UITextField {
    
    func setBottomBorder(backGroundColor: UIColor, borderColor: UIColor) {
        self.layer.backgroundColor = backGroundColor.cgColor
        
        // Layer shadows
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowColor = borderColor.cgColor
    }
}


// Dune: Layout anchor method
extension UIView {
    func anchors(top: NSLayoutYAxisAnchor?, topPad: CGFloat, bottom: NSLayoutYAxisAnchor?, bottomPad: CGFloat, left: NSLayoutXAxisAnchor?, leftPad: CGFloat, right: NSLayoutXAxisAnchor?, rightPad: CGFloat, height: CGFloat, width: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPad).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomPad).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftPad).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: rightPad).isActive = true
        }
        
        if height > 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width > 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
    
    
}
