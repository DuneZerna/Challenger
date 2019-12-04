//
//  SigninViewController.swift
//  Challenger
//
//  Created by Dune Zerna on 04/12/2019.
//  Copyright © 2019 University of Southern Denmark. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        

        // Do any additional setup after loading the view.
    } 
    
    

    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let defaults = UserDefaults.standard

        if (usernameTextfield.text?.isEmpty)! || (passwordTextfield.text?.isEmpty)! {
            displayMessage(userMessage: "Please fill out all fields")
        } else {
            if ((passwordTextfield.text?.elementsEqual(defaultsKeys.keyTwo))! != true) || ((usernameTextfield.text?.elementsEqual(defaultsKeys.keyOne))! != true){
                displayMessage(userMessage: "Wrong credentials")
                print("Username: " + defaultsKeys.keyOne)
                print("Password: " + defaultsKeys.keyTwo)
            } else {
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
                self.present(nextViewController, animated:true, completion:nil)
            }
        }


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
