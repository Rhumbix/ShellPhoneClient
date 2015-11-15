//
//  LoginViewController.swift
//  Shellphone
//
//  Created by Jonathan Sandness on 11/14/15.
//  Copyright © 2015 sandness. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userID: UITextField!
    
    @IBAction func signInPressed(sender: AnyObject) {
        self.resignFirstResponder()
        
        let vc:ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("listVC") as!ViewController
        
        vc.userID = self.userID.text!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = true
    }
    
}
