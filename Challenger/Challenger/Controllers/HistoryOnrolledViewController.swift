//
//  HistoryOnrolledViewController.swift
//  progress
//
//  Created by Pernille Madsen on 20/11/2019.
//  Copyright © 2019 Pernille Madsen. All rights reserved.
//

import UIKit

class HistoryOnrolledViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    @IBOutlet weak var historyImage: UIImageView!
    @IBOutlet weak var historyTitle: UILabel!
    @IBOutlet weak var historyDesc: UILabel!
    @IBOutlet weak var savePhoto: UIButton!
    @IBOutlet weak var historyTakePhoto: UIButton!
    
    
    var historyMain: String = ""
    var historySec: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        historyTitle?.text = historyMain
        historyDesc?.text = historySec
        
        savePhoto.isHidden = true
        historyTakePhoto.isHidden = false
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        
        print("Photo saved")
        
    }
    
    
    @IBAction func historyTakePhoto(_ sender: Any) {
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
        
        savePhoto.isHidden = false
        historyTakePhoto.isHidden = true
    }
    
    // SAVE IMAGE FUNCTION not working
    
    public func saveImage (imageName: String) {
        print("saveImage")
        let fileManager = FileManager.default
        
         let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as NSString).appendingPathComponent(imageName)
        
        let image = historyImage.image!
        
        let data = image.pngData()
        
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        
        print (imagePath)
    }
    }

extension UIViewController {

    @objc func swipeAction(swipe: UISwipeGestureRecognizer)
    {
        print("swipe")
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "swipeRight", sender: self)
        default:
            break
        }
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

