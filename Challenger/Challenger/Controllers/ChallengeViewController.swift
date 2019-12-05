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

   var challenge = [" ","Run 5km","Walk 10k steps","Sleep 8 hours"]
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
    {
        label.text = "Challenge: "+challenge[row]
    }
    
    override func viewDidLoad()
    {
       
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Letsgo(_ sender: Any) {
       
        
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
