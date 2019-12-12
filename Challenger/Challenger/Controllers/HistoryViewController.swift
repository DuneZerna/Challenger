//
//  HistoryViewController.swift
//  progress
//
//  Created by Pernille Madsen on 19/11/2019.
//  Copyright © 2019 Pernille Madsen. All rights reserved.
//

import UIKit

 class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //var userNewChallenge = UserDefaults.standard.string(forKey: "challenge") ?? ""
    @IBOutlet weak var tappedView: UIView!
    @IBOutlet weak var tappedTitleLabel: UILabel!
    @IBOutlet weak var tappedDescTextField: UITextField!
    
    @IBOutlet weak var tappedDescView: UIView!
    @IBOutlet weak var tappedDescLabel: UILabel!
    
    @IBOutlet weak var historyImage: UIImageView!
    
    var images: [UIImage] = []
    
    @IBAction func takePhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                
                let actionsheet = UIAlertController(title: "Take", message: "Choose a source", preferredStyle: UIAlertController.Style.actionSheet)
                
                actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
                    (action: UIAlertAction) in imagePickerController.sourceType = .camera
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
                
                actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
                    (action: UIAlertAction) in imagePickerController.sourceType = .photoLibrary
                    
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
                
                actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:
                    nil ))
                self.present(actionsheet, animated: true, completion: nil)
                
            }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                
                
                print("imagePickerController")
                let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                
                historyImage.image = image
                
                picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        print("Photo saved")
            let imageData = historyImage.image!.pngData()
            let compressedImage = UIImage(data: imageData!)
            
            UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
            
            let alert = UIAlertController(title: "Saved", message: "Your image was saved", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        
        images.append(historyImage.image!)
            
        }
    
    
    @IBAction func tappedCancel(_ sender: Any) {
        tappedView.isHidden = true
    }
    
    @IBAction func descSave(_ sender: Any) {
        
        let newDesc = tappedDescTextField.text!
        
        print("I'm new: ", newDesc)
        
        Challenge.savedDecriptions[indexNr] = newDesc
        
        print("I'm newer", Challenge.savedDecriptions[indexNr])
        
    }
    var challenges: [String] = Challenge.savedChallenges
    var chDesc: [String] = Challenge.description
    
    var indexNr = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        tableView.backgroundColor = UIColor.white
        print(Challenge.savedChallenges)
        tappedView.isHidden = true
        tappedDescView.isHidden = true
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
        tappedView.isHidden = false
        print("Touched")
        
        tappedTitleLabel.text = Challenge.savedChallenges[indexNr]
        
        if Challenge.savedDecriptions[indexNr] == "No description yet.." {
            
            tappedDescView.isHidden = true
            print("I'm empty")
            
        } else {
            
            tappedDescView.isHidden = false
            tappedDescLabel.text = Challenge.savedDecriptions[indexNr]
            
            print("I'm not empty: ",Challenge.savedDecriptions[indexNr])
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HistoryOnrolledViewController
        {
            let onrolledHistory = segue.destination as? HistoryOnrolledViewController
            onrolledHistory?.historyMain = challenges[indexNr]
            
            onrolledHistory?.historySec = chDesc[indexNr]
        }
    }*/
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
