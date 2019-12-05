//
//  HistoryViewController.swift
//  progress
//
//  Created by Pernille Madsen on 19/11/2019.
//  Copyright © 2019 Pernille Madsen. All rights reserved.
//

import UIKit

 class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userNewChallenge = UserDefaults.standard.string(forKey: "challenge") ?? ""
    
    var challenges: [String] = ["First custom challenge", "Second custom challenge"]
    let chDesc: [String] = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet ligula ut quam pellentesque consectetur. Cras dui felis, fringilla quis mauris ac, tempus sodales nisi. In non quam rhoncus, dapibus.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec imperdiet ornare augue, a interdum eros luctus id. Aenean laoreet scelerisque pulvinar. Donec mattis augue urna, eget aliquet urna elementum quis.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce id aliquet nibh. Nunc convallis urna eget sapien venenatis feugiat. Proin non condimentum eros. Praesent at ante id risus rutrum facilisis.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin non nisi risus. Aenean iaculis, lectus non finibus rutrum, erat turpis mollis ante, eget vestibulum nisi ligula et sapien. Aliquam nunc."]
    
    var indexNr = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.white
        
        challenges.append(userNewChallenge)
        
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
