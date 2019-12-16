//
//  RegisterUserViewController.swift
//  Challenger
//
//  Created by Dune Zerna on 04/12/2019.
//  Copyright © 2019 University of Southern Denmark. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var firstnameTextfield: UITextField!
    
    @IBOutlet weak var lastnameTextfield: UITextField!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var repeatPasswordTextfield: UITextField!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel")
        
        self.dismiss(animated: true, completion: nil)
    }
    

    
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("Signup")
        
        // Dune: Textfields validation
        if (firstnameTextfield.text?.isEmpty)! || (lastnameTextfield.text?.isEmpty)! || (emailTextfield.text?.isEmpty)! || (passwordTextfield.text?.isEmpty)! {
            
            displayMessage(userMessage: "All fields are required")
            
            return
        } else if (emailTextfield.text?.isValidEmail() == false){
            displayMessage(userMessage: "Damn fool, not a valid email")
        } else {
            
            if ((passwordTextfield.text?.elementsEqual(repeatPasswordTextfield.text!))! != true) {
                displayMessage(userMessage: "Password doesn't match homie")
            } else {
                
                userProfile.saveInfo(username: emailTextfield.text ?? "", password: passwordTextfield.text ?? "", firstName: firstnameTextfield.text ?? "", lastName: lastnameTextfield.text ?? "", gender: userProfile.gender.man.returnGender())
                UserDefaults.standard.set(emailTextfield.text, forKey: "username")
                let username = UserDefaults.standard.string(forKey: "username") ?? ""
                UserDefaults.standard.set(passwordTextfield.text, forKey: "password")
                let password = UserDefaults.standard.string(forKey: "password") ?? ""

                // Dune: Display profile info for testing purposes
                displayMessage(userMessage: "Userprofile: \n" + "Username: " + username + "\n" + "Password: " + password)
                
                userProfile.saveInfo(username: emailTextfield.text ?? "", password: passwordTextfield.text ?? "", firstName: firstnameTextfield.text ?? "", lastName: lastnameTextfield.text ?? "", gender: userProfile.gender.other.returnGender())
                
                print()
            }
            
        }
        
        // Dune: Create activity indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        // Dune: Position activity indicator in the center of main view
        myActivityIndicator.center = view.center
        
        // Dune: Callback prevention
        myActivityIndicator.hidesWhenStopped = false
        
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
