//
//  ViewController.swift
//  Challenger
//
//  Created by Dune Zerna on 08/11/2019.
//  Copyright © 2019 University of Southern Denmark. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let emailTextField: UITextField = {
       let e = UITextField()
        
        let attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        e.textColor = .black
        e.attributedPlaceholder = attributedPlaceholder
        e.setBottomBorder(backGroundColor: WHITE_THEME, borderColor: .black)
        
        
        
        return e
    }()
    
    // Dune: Email textfield created programatically
    
    let passwordTextField: UITextField = {
        let p = UITextField()
        let attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        p.isSecureTextEntry = true
        p.attributedPlaceholder = attributedPlaceholder
        p.setBottomBorder(backGroundColor: WHITE_THEME, borderColor: .black)
        
        return p
    }()
    
    let loginButton: UIButton = {
        let l = UIButton(type: .system)
        l.setTitleColor(.white, for: .normal)
        l.setTitle("Log in", for: .normal)
        l.backgroundColor = UIColor.rgb(r: 89, g: 156, b: 120)
        l.layer.cornerRadius = 10
        
        l.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return l
    }()
    

    let logo: UIImageView = {
        let l = UIImageView()
        // fill in correct image
        //l.image = ##imageLiteral(resourceName: "icon")
        l.contentMode = .scaleAspectFill
        l.layer.masksToBounds = true
        l.layer.cornerRadius = 20
        
        return l
    }()
 

    let forgotPassword: UIButton = {
        let f = UIButton(type: .system)
        f.setTitleColor(.white, for: .normal)
        f.setTitle("Forgot Password?", for: .normal)
        f.backgroundColor = WHITE_THEME
        return f
    }()
    
    let haveAccountButton: UIButton = {
        let font = UIFont.systemFont(ofSize: 16)
        let color = UIColor.rgb(r: 89, g: 156, b: 120)
        let h = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font : font])
        h.setAttributedTitle(attributedTitle, for: .normal)
        h.backgroundColor = WHITE_THEME
        
        attributedTitle.append(NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font]))
        
        h.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        
        //Dune: Attributed method is used to have the color and text change without overriding the current text
        
        return h
    }()
    
    // Dune: Password textfield created programatically

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = WHITE_THEME
        
        navigationController?.isToolbarHidden = true
        
        setupAddLogo()
        setupTextFieldComponents()
        setupLoginButton()
        setupHaveAccountButton()
        setupForgotPasswordButton()
    }
    
    fileprivate func setupForgotPasswordButton() {
        view.addSubview(forgotPassword)
        
        forgotPassword.anchors(top: loginButton.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: loginButton.leftAnchor, leftPad: 0, right: loginButton.rightAnchor, rightPad: 0, height: 30, width: 0)
    
        
    }

    
    fileprivate func setupTextFieldComponents() {
        setupEmailField()
        setupPasswordField()
    }

    fileprivate func setupEmailField(){
        view.addSubview(emailTextField)
        
        emailTextField.anchors(top: nil, topPad: 0, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 24, right: view.rightAnchor, rightPad: -24, height: 30, width: 0)
        
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // Dune: Anchors the subview programmatically to the view within the safe areas.
    }
    
    @objc func signupAction() {
        let signupController = SignupController()
        navigationController?.pushViewController(signupController, animated: true)
    }
    
    @objc func loginAction() {
        let menuViewController = MenuViewController()
        navigationController?.pushViewController(menuViewController, animated: true)
    }
    
    // TODO: Set up logo initialisation
  
    fileprivate func setupAddLogo() {
        view.addSubview(logo)
        
        logo.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 64, bottom: nil, bottomPad: 0, left: nil, leftPad: 0, right: nil, rightPad: 0, height: 150, width: 150)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        // Lightcontent is intended for dark backgrounds
    }
    
    fileprivate func setupPasswordField(){
        view.addSubview(passwordTextField)
        
        passwordTextField.anchors(top: emailTextField.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: emailTextField.leftAnchor, leftPad: 0, right: emailTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
        
        // Dune: Anchors the subview programmatically to the view within the safe areas.
    }
    
    fileprivate func setupLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.anchors(top: passwordTextField.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: passwordTextField.leftAnchor, leftPad: 0, right: passwordTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
    }
    
    fileprivate func setupHaveAccountButton() {
        view.addSubview(haveAccountButton)
        
        haveAccountButton.anchors(top: nil, topPad: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, bottomPad: -8, left: view.leftAnchor
            , leftPad: 12, right: view.rightAnchor, rightPad: -12, height: 30, width: 0)

    }
}

