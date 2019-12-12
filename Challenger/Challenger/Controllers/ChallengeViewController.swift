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
    var runningChallenges: [String] = Challenge.predefinedChallenges
    var activeRunningChallenges: [String] = Challenge.activeChallenges
    
    var indexNr = 0
    var stepCount = 0
    
    let healthStore = HKHealthStore()
    
    
    @IBOutlet weak var createView: UIView!
    @IBOutlet weak var runningView: UIView!
    @IBOutlet weak var runningTable: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!

    @IBAction func createButton(_ sender: Any) {
        
        createView.isHidden = false
        runningView.isHidden = true
        
    }
    @IBAction func runningButton(_ sender: Any) {
        runningView.isHidden = false
        createView.isHidden = true
        
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
                    Challenge.activeChallenges.append(String(savedChallengeInt))
                    print("I appended")
                    
                    print("Active:",Challenge.activeChallenges)
                    
                    print ("Challenge is larger")
                }
            }
            
        
        
        if challengeInt != 0 {
            let alert = UIAlertController(title: "Success", message: "Your challenge was created!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
            print("I succeeded")
            //Challenge.challenges.append(textField.text!)
            
            // Dune: Method for saving new challenges & descriptions
            saveChallenge(newChallenge: textField.text!)
            saveDescription(newDescription: "")
            print(Challenge.savedChallenges)
            
        }
        
        else {
            let alert = UIAlertController(title: "Error!", message: "You may only use numbers", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }
            
            
        
        
        
        //Testing
        
               if challengeInt <= stepCount {
                   print(challengeInt, stepCount, "Go you")
               }
        
    }
    
    func numberOfSections(in runningTable: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ runningTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeRunningChallenges.count
    }
    
    func tableView(_ runningTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = runningTable.dequeueReusableCell(withIdentifier: "runningCell") as! runningTableCell
        cell.runningLabel?.text = activeRunningChallenges[indexPath.row]
        return cell
    }
    
    func tableView(_ runningTable: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
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
        
        
           createView.isHidden = false
           runningView.isHidden = true
        runningChallenges.append(contentsOf: Challenge.savedChallenges)
        
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
