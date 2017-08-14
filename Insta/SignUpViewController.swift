//
//  SignUpViewController.swift
//  Insta
//
//  Created by Taimoor Saeed on 22/07/2017.
//  Copyright © 2017 Taimoor. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    @IBAction func signUpPressed(_ sender: AnyObject) {
        
        let ref : DatabaseReference!
        ref = Database.database().reference()
        
        
        if self.emailTextFeild.text! == "" || self.passwordTextFeild.text! == "" {
            
            let alertController = UIAlertController(title: "Error", message: "You missed email or password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
            
        else {
            
            _ = Auth.auth().createUser(withEmail: self.emailTextFeild.text!, password: self.passwordTextFeild.text!) { (user , error) in
                
                if error == nil {
                    print("You have sucessfully signed up")
                    
//                    ref.child("users").child(user!.uid).setValue(["name": self.emailTextFeild.text!])
                    
                    ref.child("users").child((user?.uid)!).setValue(["name": self.emailTextFeild.text!])
                    
//                    self.ref.child("users/(user.uid)).childByAutoId.setValue(["name": self.emailTextFeild.text!])
                    
                    
                    let vc  = self.storyboard?.instantiateViewController(withIdentifier: "signIn")
                    self.present(vc!, animated: true, completion: nil)
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
