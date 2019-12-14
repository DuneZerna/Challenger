//
//  SigninViewController.swift
//  Challenger
//
//  Created by Dune Zerna on 04/12/2019.
//  Copyright © 2019 University of Southern Denmark. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    var alreadyLogged: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    // Dune: Method that runs after the view is loaded and animated
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
                // Dune: Checks if there is already a login available
        if (UserDefaults.standard.string(forKey: "username") != nil || UserDefaults.standard.string(forKey: "password") != nil){

                alreadyLoggedFunc()
            
        }
    }
    
    

    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    // Dune: Login function
    @IBAction func loginButton(_ sender: Any) {
       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        let password = UserDefaults.standard.string(forKey: "password") ?? ""
        
        // Dune: Textfield validation, if empty, deny entry
        if (usernameTextfield.text?.isEmpty)! || (passwordTextfield.text?.isEmpty)! {
            displayMessage(userMessage: "Please fill out all fields")
        } else {
            // Dune: Login validation, if invalid, try again
            if ((passwordTextfield.text?.elementsEqual(password))! != true) || ((usernameTextfield.text?.elementsEqual(username))! != true){
                displayMessage(userMessage: "Wrong credentials")
                print("Username: " + username)
                print("Password: " + password)
            } else {
                // Dune: If valid, present next view
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
                self.present(nextViewController, animated:true, completion:nil)
            }
        }


     }
    
    // Dune: Validates user session
    fileprivate func alreadyLoggedFunc(){
        print("Already logged")
        let alreadyLoggedBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = alreadyLoggedBoard.instantiateViewController(withIdentifier: "Root") as! NavigationViewController
        nextViewController.modalPresentationStyle = .fullScreen
                     self.present(nextViewController, animated:true, completion:nil)
        
        
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
