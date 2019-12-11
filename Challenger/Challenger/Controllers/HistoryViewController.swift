//
//  HistoryViewController.swift
//  progress
//
//  Created by Pernille Madsen on 19/11/2019.
//  Copyright © 2019 Pernille Madsen. All rights reserved.
//

import UIKit

 class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var userNewChallenge = UserDefaults.standard.string(forKey: "challenge") ?? ""
    
    var challenges: [String] = Challenge.predefinedChallenges
    var chDesc: [String] = Challenge.description
    
    var indexNr = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.white
        challenges.append(contentsOf: Challenge.challenges)
        //challenges.append(userNewChallenge)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
    }

     

     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryTableCell
        cell.tableCell?.text = challenges[indexPath.row]
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexNr = indexPath.row
        performSegue(withIdentifier: "HistorySegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HistoryOnrolledViewController
        {
            let onrolledHistory = segue.destination as? HistoryOnrolledViewController
            onrolledHistory?.historyMain = challenges[indexNr]
            
            onrolledHistory?.historySec = chDesc[indexNr]
        }
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
