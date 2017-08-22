//
// SignInViewController.swift
//  Insta
//
//  Created by Taimoor Saeed on 21/07/2017.
//  Copyright © 2017 Taimoor. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    @IBAction func prepareForUnWind(sender: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func signInPressed(_ sender: AnyObject) {
        
        if self.emailTextFeild.text! == "" || self.passwordTextFeild.text! == "" {
            
            let alertController = UIAlertController(title: "Error", message: "You missed email or password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
            
        else {
            
            _ = Auth.auth().signIn(withEmail: self.emailTextFeild.text!, password: self.passwordTextFeild.text!) { (user , error) in
                
                if error == nil {
                    print("You have sucessfully logged in")
                    
                    let vc  = self.storyboard?.instantiateViewController(withIdentifier: "home")
//                    self.present(vc!, animated: true, completion: nil)
                    self.navigationController!.pushViewController(vc!, animated: true)
                    
                    
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

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
}
