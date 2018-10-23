//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Ching Ching Huang on 10/11/18.
//  Copyright © 2018 Ching Ching Huang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var messagePosts: [PFObject] = []
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = PFUser.current() {
            print("Welcome back \(currentUser.username!) :)")
            self.callAlertDismiss(title: "Welcome", message: "Welcome back \(currentUser.username!)")
        }
        
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = self.messageTF.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success{
                print("The message was saved!")
                self.messageTF.text = ""
            }else if let error = error{
                print("Problem saving message: \(error.localizedDescription)")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let chatMessage = messagePosts[indexPath.row]
        if let msg = chatMessage["text"] as? String {
            cell.messageLabel.text = msg
        } else {
            cell.messageLabel.text = ""
        }
        
        if let user = chatMessage["user"] as? PFUser {
            cell.userLabel.text = user.username
        } else {
            cell.userLabel.text = "🤖"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.messagePosts.count
    }
    
    private func updateMessages() {
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let objects = objects {
                self.messagePosts = objects
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    @objc func onTimer() {
        // code to be run periodically
        let query = PFQuery(className: "Message")
        query.whereKeyExists("text").includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.messagePosts = posts
                self.tableView.reloadData()
                
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        onTimer()
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    func callAlertDismiss(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) {(action) in}
        alertController.addAction((dismissAction))
        self.present(alertController, animated: true) {
        }
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
