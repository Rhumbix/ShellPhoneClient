//
//  LoginViewController.swift
//  Shellphone
//
//  Created by Jonathan Sandness on 11/14/15.
//  Copyright © 2015 sandness. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var userID: UITextField!
    
    @IBOutlet weak var teamName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.teamName.delegate = self
    }
    
    @IBAction func signInPressed(sender: AnyObject) {
        self.resignFirstResponder()
        
        let vc:UITabBarController = self.storyboard!.instantiateViewControllerWithIdentifier("tabVC") as!UITabBarController
        
        var someVCVCCopy:ViewController?
        for someVC:UIViewController in vc.viewControllers!{
            if someVC.isKindOfClass(ViewController){
                let someVCVC:ViewController = someVC as! ViewController
                someVCVC.userID = self.userID.text!
                someVCVCCopy = someVCVC
            }else if someVC.isKindOfClass(MapVC){
                let someOtherVC:MapVC = someVC as! MapVC
                someVCVCCopy!.mapVC = someOtherVC
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.teamName.resignFirstResponder()
        self.view.resignFirstResponder()
        return false
    }
    
}
