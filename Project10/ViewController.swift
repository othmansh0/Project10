//
//  ViewController.swift
//  Project10
//
//  Created by othman shahrouri on 8/25/21.
//

import UIKit
//UIImagePickerControllerDelegate: Tell us when the user either selected a picture or cancelled the picker

//UINavigationControllerDelegate:


//UserDefaults to store any basic data < 100KB
//you can save any kind of data inside UserDefaults as long as you follow some rules:

// Use archivedData() method which turns an object graph into a data object then write that to UserDefaults
//“object graph” means “your object, plus any objects it refers to

//1.All your data types must be one of the following: boolean, integer, float, double, string, array, dictionary, Date, or a class that fits rule 2.
//2.If your data type is a class, it must conform to the NSCoding protocol, which is used for archiving object graphs.
//3.If your data type is an array or dictionary, all the keys and values must match rule 1 or rule 2.

class ViewController: UICollectionViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //This function returns a cell of type UICollectionViewCell rather than a Person cell
        //We need to type cast it to our custom cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to deuque PersonCell")
        }
        
        //1.Pull out the person from the people array at the correct position
        let person = people[indexPath.item]
        //2.Set the name label to the person's name
        cell.name.text = person.name
        //3.Create a UIImage from the person's image filename
        //adding it to the value from getDocumentsDirectory() so that we have a full path for the image
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ac = UIAlertController(title: "Please Choose", message: nil, preferredStyle: .actionSheet)
        
        
        let action = UIAlertAction(title: "Rename Person", style: .default) {[weak self]
            action in
            let ac2 = UIAlertController(title: "Add a person", message: nil, preferredStyle: .alert)
            ac2.addTextField()
            
            let addAction = UIAlertAction(title: "Add", style: .default){[weak self,weak ac2] action in
                guard let newName = ac2?.textFields?[0].text else {return}
                self?.people[indexPath.item].name = newName
                collectionView.reloadData()
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            ac2.addAction(cancelAction)
            ac2.addAction(addAction)
            
            self?.present(ac2, animated: true, completion: nil)
            
            
        }
        
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ [weak self]
                    action in
                    self?.people.remove(at: indexPath.item)
                    collectionView.reloadData()
        
                }
        
        
        ac.addAction(action)
        ac.addAction(deleteAction)
        
        
        present(ac, animated: true, completion: nil)
        
        
        
     
        
        
        //        ac2.addAction(deleteAction)
        
        
        
    }
    
    
    @objc func addNewPerson(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true

        
        
        //means we respond to messages from the picker
        //but we must conform to 2 procols
        picker.delegate = self
        present(picker,animated: true)
        
        
    }
    
    
    
    
    
    //steps:
    //1-Extract the image from the dictionary that is passed as a parameter
    //This dictionary parameter will contain key: .editedImage
    //We don't know if this value exists as a UIImage, so we can't just extract it. Instead, we need to use an optional method of typecasting, as?
    
    //2-we need to generate a unique filename for every image we import.so that we can copy it to our app's space on the disk without overwriting anything even if user delete it we would still hae a copy we're going to use a new type for this, called UUID
    
    //3-After having the image and a path where we want to save it
    //  we need to convert the UIImage to a data object so it can be saved
    
    
    //which returns when the user selected an image and it's being returned to you
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //1-
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        //create an UUID object, and use its uuidString property to extract the unique identifier as a string
        let imageName = UUID().uuidString
        //appendingPathComponent().Used when working with file paths, and adds one string (imageName) to a path, including whatever path separator is used on the platform
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        //Converting UIImage to a data object so it can be saved
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Othman", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}

