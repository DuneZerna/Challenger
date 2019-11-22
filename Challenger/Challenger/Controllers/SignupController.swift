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
        
        setupHaveAccount()
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
}
