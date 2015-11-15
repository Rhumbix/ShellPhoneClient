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
        
        let vc:UITabBarController = self.storyboard!.instantiateViewControllerWithIdentifier("tabVC") as!UITabBarController
        
        
        
        /*let item:UITabBarItem vc.tabBar.items![0] [vc.tabBar.items objectAtIndex:0];
        item.setTit*/
        
        for someVC:UIViewController in vc.viewControllers!{
            if someVC.isKindOfClass(ViewController){
                let someVCVC:ViewController = someVC as! ViewController
                someVCVC.userID = self.userID.text!
                
                
                someVCVC.tabBarItem = UITabBarItem(title: "List View", image: nil, tag: 0)
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = true
    }
    
}
