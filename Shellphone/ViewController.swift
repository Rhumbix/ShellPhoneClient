//
//  ViewController.swift
//  Shellphone
//
//  Created by Jonathan Sandness on 11/14/15.
//  Copyright © 2015 sandness. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var recipientName: UITextField!
    @IBOutlet weak var myUsernameLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    var crewMembers:[String] = ["jon","george","cameron"]
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        
        presentUsernameInput()
    }

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentUsernameInput(){
        var inputTextField: UITextField?
        
        let alertController = UIAlertController(title: "Title", message: "Enter your username", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let username = inputTextField!.text!
            SinchConnector.sharedInstance.setupSinch(username,vc: self)
            self.myUsernameLabel.text = "Me: " + username
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            inputTextField = textField
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func selectTalkingUser(uID:String){
        let userId = uID.lowercaseString
        print("selectTalkingUser:" + userId)
        let index = self.crewMembers.indexOf(userId)
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        let cell:UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        let statusImage:UIView = cell.viewWithTag(2)!
        statusImage.backgroundColor = UIColor.greenColor()
    }
    
    func deselectTalkingUser(uID:String){
        let userId = uID.lowercaseString
        print("deselectTalkingUser:" + userId)
        let index = self.crewMembers.indexOf(userId)
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        let cell:UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        let statusImage:UIView = cell.viewWithTag(2)!
        statusImage.backgroundColor = UIColor.whiteColor()
    }
    

    @IBAction func conferenceBegin(sender: AnyObject) {
        SinchConnector.sharedInstance.startConference()
    }
    
    // Table view 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.crewMembers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("crewCell")! as UITableViewCell
        cell.selectionStyle = .None;
        
        let label:UILabel = cell.viewWithTag(1) as! UILabel
        label.text = self.crewMembers[indexPath.row]
        
        let button:UIButton = cell.viewWithTag(3)! as! UIButton
        button.addTarget(self, action: "cellTouchDown:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    func cellTouchDown(sender:UIButton){
        if let _ = SinchConnector.sharedInstance.activeCall{
            // End Call
            let cell:UITableViewCell = sender.superview!.superview! as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            
            let statusImage:UIView = cell.viewWithTag(2)!
            statusImage.backgroundColor = UIColor.whiteColor()
            
            SinchConnector.sharedInstance.endCall()
        }else{
            // Start call
            let cell:UITableViewCell = sender.superview!.superview! as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            
            let statusImage:UIView = cell.viewWithTag(2)!
            statusImage.backgroundColor = UIColor.greenColor()
            
            let crewUserID = self.crewMembers[indexPath.row]
            SinchConnector.sharedInstance.startCall(crewUserID)
        }
        
        
    }

}

