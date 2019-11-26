//
//  StepsViewController.swift
//  progress
//
//  Created by Pernille Madsen on 20/11/2019.
//  Copyright © 2019 Pernille Madsen. All rights reserved.
//

import UIKit
import HealthKit

class StepsViewController: UIViewController {

    @IBOutlet weak var stepsLabel: UILabel!
    
    let healthStore = HKHealthStore()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if HKHealthStore.isHealthDataAvailable(){
            print("It's available!")
        } else {
            print("It's not available")
        }
        
        
        
        let allTypes = Set([HKObjectType.workoutType(),
                            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                            HKObjectType.quantityType(forIdentifier: .stepCount)!,
                            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!])

        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if (success){
                self.getSteps {(result) in
                    
                    DispatchQueue.main.async {
                        let stepCount = Int(result)
                        self.stepsLabel.text = String(stepCount) + (" / 10.000 steps")
                        
                    }
                    
                }
            }
        }
    }
    

}
