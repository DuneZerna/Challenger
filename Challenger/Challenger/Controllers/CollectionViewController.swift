//
//  collectionViewController.swift
//  progress
//
//  Created by Pernille Madsen on 18/11/2019.
//  Copyright © 2019 Pernille Madsen. All rights reserved.
//

import UIKit

// Dune: If this gives an error, try refactor the name to collectionViewController
class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViews: UICollectionView!
    
    let pictures: [String] = ["IMG_0792", "IMG_0793", "IMG_0794", "IMG_0795", "IMG_0796", "IMG_0797", "IMG_0800", "IMG_0818"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(pictures.count)
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
        
        cell.myImageView.image = UIImage(named: pictures[indexPath.row])
        
        print("I've printed")
        
        return cell
        
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
