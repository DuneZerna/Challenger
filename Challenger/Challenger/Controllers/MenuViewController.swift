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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuView()
    }
    
    fileprivate func setupMenuView() {
        let menuViewController = storyBoard.instantiateViewController(withIdentifier: "Menu")
        self.present(menuViewController, animated:true, completion:nil)
        
        
        
    }
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    
    
    
}

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


