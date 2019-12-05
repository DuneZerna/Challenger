//
//  MenuViewController.swift
//  progress
//
//  Created by Pernille Madsen on 20/11/2019.
//  Copyright © 2019 Pernille Madsen. All rights reserved.
//

import UIKit
import HealthKit

class MenuViewController: UIViewController {
    
    
//        let usernameID = UserDefaults.standard.string(forKey: "username") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuView()
        setupUserProfile()
        
    }
    
    let userprofile: UILabel = {
        let u = UILabel()
        u.textColor = UIColor.rgb(r: 0, g: 0, b: 0)
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        u.text = username
        
//        let color = UIColor.rgb(r: 89, g: 156, b: 120)
//        let font = UIFont.systemFont(ofSize: 16)
//
//        let h = UIButton(type: .system)
//            h.backgroundColor = WHITE_THEME
//        let attributedTitle = NSMutableAttributedString(string: "Already have an account?", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
//
//        attributedTitle.append(NSAttributedString(string: " Sign in", attributes: [NSMutableAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font]))
//
//        h.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
//        h.setAttributedTitle(attributedTitle, for: .normal)
        
        return u
    }()
    
    fileprivate func setupUserProfile() {
        view.addSubview(userprofile)
        
        userprofile.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 50, bottom: nil, bottomPad: 8, left: view.leftAnchor, leftPad: 190, right: view.rightAnchor, rightPad: -190, height: 20, width: 0)
    }
    
    fileprivate func setupMenuView() {
        
        let menuViewController = storyBoard.instantiateViewController(withIdentifier: "Menu")
        self.present(menuViewController, animated:true, completion:nil)
        
    }
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    @IBOutlet weak var username: UILabel!
    
    
    
    
    

    
    
}

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


