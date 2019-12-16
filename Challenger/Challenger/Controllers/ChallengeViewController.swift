//
//  ChallengeViewController.swift
//  progress
//
//  Created by Pernille Madsen on 07/11/2019.
//  Copyright © 2019 Pernille Madsen. All rights reserved.
//

import UIKit
import HealthKit

class ChallengeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource  {

    var text=""
    
    // Diana: Gets predefinedChallenges string array from the Challenge class
    //Pernille: and activeChallenge
    var runningChallenges: [String] = Challenge.predefinedChallenges
    var activeRunningChallenges: [String] = Challenge.activeChallenges
    
    var indexNr = 0
    
    //Pernille: For stepCounter setup
    let healthStore = HKHealthStore()
    var stepCount = 0
    
    
    @IBOutlet weak var createView: UIView!
    @IBOutlet weak var runningView: UIView!
    @IBOutlet weak var runningTable: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!

    
    //Pernille: Show and hide different views, dependent on button pressed
    @IBAction func createButton(_ sender: Any) {
        
        createView.isHidden = false
        runningView.isHidden = true
        
    }
    @IBAction func runningButton(_ sender: Any) {
        runningView.isHidden = false
        createView.isHidden = true
        
    }
   
    @IBAction func menuButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //Diana: Making a picker menu from the predefinedChallenges in the Challenge class
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return runningChallenges[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return runningChallenges.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        
        //Diana: appends the selected challenge from the menu to the a label
    {
        label.text = "Challenge: "+runningChallenges[row]
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Pernille: When button 'Letsgo' pressed: check if stepcount is less than challenge goal, and append to activeChallenges
    @IBAction func Letsgo(_ sender: Any) {
        
        print("Active: ",Challenge.activeChallenges)
       
        var challengeText = textField.text ?? ""
        let challengeInt = Int(challengeText) ?? 0
        
        for savedChallenge in Challenge.savedChallenges {
                let savedChallengeInt = Int(savedChallenge) ?? 0
                
                
                if Float(stepCount) >= Float(savedChallengeInt){
                    
                print("StepCount is larger")
                }
                
                else {
//                    Challenge.activeChallenges.append(String(savedChallengeInt))
                    
                    // Dune: Method for saving active challenges.
                    saveActiveChallenge(activeChallenge: String(savedChallengeInt))
                    saveChallenge(newChallenge: String(savedChallengeInt))
                    print("I appended")
                    
                    print("Active:",Challenge.activeChallenges)
                    
                    print ("Challenge is larger")
                }
            }
            
        
        //Pernille: if you wrote only numbers in the textField, your challenge was created
        if challengeInt != 0 {
//            let alert = UIAlertController(title: "Success", message: "Your challenge was created!", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
//            alert.addAction(okAction)
//            self.present(alert, animated: true, completion: nil)
            
            // Dune: Option to save a description
            
            let descriptionAlert = UIAlertController(title: "Description", message: nil, preferredStyle: .alert)
            descriptionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            descriptionAlert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Describe your challenge here..."
            })

            descriptionAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

                if let description = descriptionAlert.textFields?.first?.text {
                    self.saveDescription(newDescription: description)
                    print(Challenge.savedDescriptions)
                } else {
                    self.saveDescription(newDescription: "No description yet..")
                    print(Challenge.savedDescriptions)
                }
            }))

            self.present(descriptionAlert, animated: true)
            
            print("I succeeded")
            //Challenge.challenges.append(textField.text!)
            
            // Dune: Method for saving new challenges & descriptions
            // saveChallenge(newChallenge: textField.text!)
            //saveDescription(newDescription: "")
            print(Challenge.savedChallenges)
            
        }
        
            //Pernille: if you wrote letters in the textField, error occurs
        else {
            let alert = UIAlertController(title: "Error!", message: "You may only use numbers", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    //Pernille: setup of TableView in 'runningView'. Holds only activeChallenges
    
    //ERROR!!: The tableView does not update before a different viewController has been viewed! The last appended activeChallenge does not show either!
    
    func numberOfSections(in runningTable: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ runningTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeRunningChallenges.count
    }
    
    func tableView(_ runningTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = runningTable.dequeueReusableCell(withIdentifier: "runningCell") as! runningTableCell
        print("I'm creating")
        cell.runningLabel?.text = activeRunningChallenges[indexPath.row]
        return cell
    }
    
    func tableView(_ runningTable: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    //Pernille: getting steps
    func getSteps(completion: @escaping (Double) -> Void){
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        var interval = DateComponents()
        interval.day = 1
        
        let query = HKStatisticsCollectionQuery(
            quantityType: stepsQuantityType, quantitySamplePredicate: nil, options: [.cumulativeSum], anchorDate: startOfDay, intervalComponents: interval)
        
        query.initialResultsHandler = {_, result, error in
            var resultCount = 0.0
            result!.enumerateStatistics(from: startOfDay, to: now) {
                statistics, _ in
                if let sum = statistics.sumQuantity(){
                        resultCount = sum.doubleValue(for: HKUnit.count())
                }
            }
            
            DispatchQueue.main.async {
                completion(resultCount)
            }
        }
        
        query.statisticsUpdateHandler = {
            query, statistics, statisticsCollection, error in
            
            if let sum = statistics?.sumQuantity(){
                let resultCount = sum.doubleValue(for: HKUnit.count())
                
                DispatchQueue.main.async {
                    completion(resultCount)
                }
            }
        }
        healthStore.execute(query)
    }
    
    override func viewDidLoad()
       {
          //Diana: hides the keyboard, when you a tap random place on the screen.
           super.viewDidLoad()
           self.hideKeyboardWhenTappedAround()
        
        //Pernille: first view to be shown is createView
           createView.isHidden = false
           runningView.isHidden = true
        runningChallenges.append(contentsOf: Challenge.savedChallenges)
        
        
        //Pernille: more steps
        if HKHealthStore.isHealthDataAvailable(){
            print("It's available!")
        } else {
            print("It's not available")
        }
        let steps = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])

        healthStore.requestAuthorization(toShare: steps, read: steps) { (success, error) in
            if (success){
                self.getSteps {(result) in
                    
                    DispatchQueue.main.async {
                        self.stepCount = Int(result)
                        print(self.stepCount)
                        
                    }
                    
                }
            }
        
       }
        
}
}
