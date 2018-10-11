//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Ching Ching Huang on 10/11/18.
//  Copyright © 2018 Ching Ching Huang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.layer.borderColor = UIColor.lightGray.cgColor;
        usernameLabel.layer.borderWidth = 1
        usernameLabel.layer.masksToBounds = true
        usernameLabel.layer.cornerRadius = 4
        passwordLabel.layer.borderColor = UIColor.lightGray.cgColor;
        passwordLabel.layer.borderWidth = 1
        passwordLabel.layer.masksToBounds = true
        passwordLabel.layer.cornerRadius = 4
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
