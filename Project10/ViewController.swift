//
//  ViewController.swift
//  Project10
//
//  Created by othman shahrouri on 8/25/21.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //This function returns a cell of type UICollectionViewCell rather than a Person cell
        //We need to type cast it to our custom cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to deuque PersonCell")
        }
       
        
        
        return cell
    }


}

