//
//  ImageViewController.swift
//  Insta
//
//  Created by Taimoor Saeed on 22/07/2017.
//  Copyright © 2017 Taimoor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import MBProgressHUD

class ImageViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var kbHeight: CGFloat = 0.0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        imagePicker.delegate = self
    }
    
    @IBAction func loadImagePressed(_ sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SavePressed(_ sender: AnyObject) {
        
        guard self.imageView.image != nil else {
            print("select an image")
            return
        }
        
       
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
       loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Uploading"
        
        let ref = Database.database().reference()
        
        let user = Auth.auth().currentUser
        
        let imageData = UIImageJPEGRepresentation(self.imageView.image!, 0.1)
        
        let imageName = "\(arc4random()).png"
        
        Storage.storage().reference().child(imageName).putData(imageData!, metadata: nil) { metadata, error in
            
            guard (error == nil) else {
                print(error!.localizedDescription)
                return
            }
            
            let downloadURL = metadata!.downloadURL()!.absoluteString
            
            let entry = [ "imageURL" : downloadURL , "text": self.textField.text! ]
            
            ref.child("posts/\(user!.uid)").childByAutoId().setValue(entry) { (error , ref ) in
                
                guard (error == nil) else {
                    print(error!.localizedDescription)
                    return
                }
            
                
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
//                self.dismiss(animated: true, completion: nil)
                
                let vc  = self.storyboard?.instantiateViewController(withIdentifier: "home")
                self.navigationController!.pushViewController(vc!, animated: true)
            }
            
        }
        
        
        
    }
}

