//
//  Extensions.swift
//  Challenger
//
//  Created by Dune Zerna on 15/11/2019.
//  Copyright © 2019 University of Southern Denmark. All rights reserved.
//

import UIKit


// Dune: Method for dismissing keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
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
