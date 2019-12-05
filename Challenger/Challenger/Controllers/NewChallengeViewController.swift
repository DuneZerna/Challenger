//
//  NewChallengeViewController.swift
//  Challenger
//
//  Created by Dune Zerna on 04/12/2019.
//  Copyright © 2019 University of Southern Denmark. All rights reserved.
//

import UIKit

class NewChallengeViewController: UIViewController {


    @IBOutlet weak var newest: UILabel!
    
    var newtext=""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newest.text=newtext
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
