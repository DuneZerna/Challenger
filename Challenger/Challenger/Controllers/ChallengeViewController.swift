//
//  ChallengeViewController.swift
//  progress
//
//  Created by Pernille Madsen on 07/11/2019.
//  Copyright © 2019 Pernille Madsen. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {

    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var text=""

    // Diana: Gets predefinedChallenges string array from the Challenge class
    var challenge = Challenge.predefinedChallenges
    
    
    //Diana: Making a picker menu from the predefinedChallenges in the Challenge class
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return challenge[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return challenge.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        
        //Diana: appends the selected challenge from the menu to the a label
    {
        label.text = "Challenge: "+challenge[row]
    }
    
    override func viewDidLoad()
    {
       //Diana: hides the keyboard, when you a tap random place on the screen.
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Letsgo(_ sender: Any) {
       
      // Diana: Sending the input from textfield to NewChallengeViewController, though a segue method.
        
        self.text=textField.text!
        performSegue(withIdentifier: "new", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "new") {
            var vc = segue.destination as!NewChallengeViewController
        vc.newtext = self.text
  }
}
    
    
}
