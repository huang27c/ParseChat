//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Ching Ching Huang on 10/11/18.
//  Copyright © 2018 Ching Ching Huang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func provideAlert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        alertController.addAction(OKAction)
        //self.activityIndicator.stopAnimating()
        present(alertController, animated: true)
    }
    
    @IBAction func onSingUp(_ sender: Any) {
        //activityIndicator.startAnimating()
        let newUser = PFUser()
        let username = usernameTextField.text
        let password = passwordTextField.text
        if (username?.isEmpty)!{
            let title =  "Email Required"
            let message = "Please enter your email address"
            provideAlert(title: title, message: message)
        }else{
            newUser.username = username
        }
        
        if (password?.isEmpty)!{
            provideAlert(title: "Password Required", message: "Please enter your password")
        }else{
            newUser.password = password
        }
        
        newUser.signUpInBackground { (success: Bool, error:Error?) in
            if let error = error{
                print(error.localizedDescription)
                let errorString = error.localizedDescription
                
                let alertController = UIAlertController(title: "Try again", message: errorString, preferredStyle: .alert)
                
                // add ok button
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {
                    (action) in
                })
                alertController.addAction(okAction)
                //self.activityIndicator.stopAnimating()
                // Show the errorString somewhere and let the user try again.
                self.present(alertController, animated: true)
                
            } else{
                print("User Signed Up successfully")
                //self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        if (username?.isEmpty)!{
            let title =  "Email Required"
            let message = "Please enter your email address"
            provideAlert(title: title, message: message)
        }
        if (password?.isEmpty)!{
            let title = "Password Required"
            let message =  "Please enter your password"
            provideAlert(title: title, message: message)
        }
        
        PFUser.logInWithUsername(inBackground: username!, password: password!) { (user: PFUser?, error: Error?) in
            if let  error = error{
                print("User log in failed: \(error.localizedDescription)")
                let errorString = error.localizedDescription
                
                let alertController = UIAlertController(title: "Try again", message: errorString, preferredStyle: .alert)
                
                // add ok button
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {
                    (action) in
                })
                alertController.addAction(okAction)
                // Show the errorString somewhere and let the user try again.
                //self.activityIndicator.stopAnimating()
                self.present(alertController, animated: true)
            }
            else{
                print("User logged in successfully")
                //self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
        }
    }
}
