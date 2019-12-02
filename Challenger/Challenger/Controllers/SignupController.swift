//
//  SignupController.swift
//  Challenger
//
//  Created by Dune Zerna on 18/11/2019.
//  Copyright © 2019 University of Southern Denmark. All rights reserved.
//

import UIKit

class SignupController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WHITE_THEME
        
        setupTextFieldComponents()
        setupHaveAccount()
        setupCreateUserButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let haveAccountButton: UIButton = {
        let color = UIColor.rgb(r: 89, g: 156, b: 120)
        let font = UIFont.systemFont(ofSize: 16)
        
        let h = UIButton(type: .system)
            h.backgroundColor = WHITE_THEME
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        
        attributedTitle.append(NSAttributedString(string: " Sign in", attributes: [NSMutableAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font]))
        
        h.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        h.setAttributedTitle(attributedTitle, for: .normal)
        
        return h
    }()
    
    @objc func signInAction() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupHaveAccount() {
        view.addSubview(haveAccountButton)
        
        haveAccountButton.anchors(top: nil, topPad: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, bottomPad: 8, left: view.leftAnchor, leftPad: 0, right: view.rightAnchor, rightPad: 0, height: 20, width: 0)
    }
    

    
    fileprivate func setupTextFieldComponents() {
        setupEmailField()
        setupPasswordField()
    }

    fileprivate func setupEmailField(){
        view.addSubview(signupEmailTextField)
        
        signupEmailTextField.anchors(top: nil, topPad: 0, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 24, right: view.rightAnchor, rightPad: -24, height: 30, width: 0)
        
        signupEmailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // Dune: Anchors the subview programmatically to the view within the safe areas.
    }
    
    fileprivate func setupPasswordField(){
        view.addSubview(signupPasswordTextField)
        
        signupPasswordTextField.anchors(top: signupEmailTextField.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: signupEmailTextField.leftAnchor, leftPad: 0, right: signupEmailTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
        
        // Dune: Anchors the subview programmatically to the view within the safe areas.
    }
    
    let signupEmailTextField: UITextField = {
       let e = UITextField()
        
        //let attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        e.textColor = .black
        e.placeholder = "Email"
        //e.attributedPlaceholder = attributedPlaceholder
        e.setBottomBorder(backGroundColor: WHITE_THEME, borderColor: .black)
        
        
        
        return e
    }()
    
    // Dune: Email textfield created programatically
    
    let signupPasswordTextField: UITextField = {
        let p = UITextField()
        //let attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        p.isSecureTextEntry = true
        p.placeholder = "Password"
        //p.attributedPlaceholder = attributedPlaceholder
        p.setBottomBorder(backGroundColor: WHITE_THEME, borderColor: .black)
        
        return p
    }()
    
    fileprivate func setupCreateUserButton() {
        view.addSubview(createUserButton)
        
        createUserButton.anchors(top: signupPasswordTextField.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: signupPasswordTextField.leftAnchor, leftPad: 0, right: signupPasswordTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
    }
    
    let createUserButton: UIButton = {
        let l = UIButton(type: .system)
        l.setTitleColor(.white, for: .normal)
        l.setTitle("Create account", for: .normal)
        l.backgroundColor = UIColor.rgb(r: 89, g: 156, b: 120)
        l.layer.cornerRadius = 10
        
        l.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        return l
    }()
    
    
    @objc func signupAction() {
        let defaults = UserDefaults.standard
        
        // Dune: Validate textfields
        if (signupEmailTextField.text?.isEmpty)! || (signupPasswordTextField.text?.isEmpty)!
        {
            let alert = UIAlertController(title: "Required fields are empty", message: "You must fill out all fields to proceed.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))

            self.present(alert, animated: true)
            
            return
        } else {
        
            defaults.set(signupEmailTextField.text, forKey: defaultsKeys.username)
            defaults.set(signupPasswordTextField.text, forKey: defaultsKeys.password)
            
            print(defaultsKeys.username)
            print(defaultsKeys.password)
        }
    }
}
