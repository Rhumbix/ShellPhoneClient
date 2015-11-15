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
    
    var userID:String?

    @IBOutlet weak var tableView: UITableView!
    
    var crewMembers:[String] = ["jon","george","cameron"]
    
    let greenColor:UIColor = UIColor(red: 184.0/255.0, green: 233.0/255.0, blue: 134.0/255.0, alpha: 1.0)
    
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
        SinchConnector.sharedInstance.setupSinch(self.userID!,vc: self)
        self.myUsernameLabel.text = "Me: " + self.userID!
    }
    
    func selectTalkingUser(uID:String){
        let userId = uID.lowercaseString
        print("selectTalkingUser:" + userId)
        let index = self.crewMembers.indexOf(userId)
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        let cell:UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        deselectUser(cell,indexPath:indexPath)
    }
    
    func deselectTalkingUser(uID:String){
        let userId = uID.lowercaseString
        print("deselectTalkingUser:" + userId)
        let index = self.crewMembers.indexOf(userId)
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        let cell:UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        deselectUser(cell,indexPath:indexPath)
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
    
    func selectUser(cell:UITableViewCell,indexPath:NSIndexPath){
        let statusImage:UIView = cell.viewWithTag(2)!
        statusImage.backgroundColor = self.greenColor
        
        let greenOvalImage:UIImageView = cell.viewWithTag(5)! as! UIImageView
        greenOvalImage.image = UIImage(named: "greenOvalDark")
        
        let label:UILabel = cell.viewWithTag(1) as! UILabel
        label.text = self.crewMembers[indexPath.row]
        label.font = UIFont(name: "Helvetica-Bold", size: 18.0)
        label.textColor = UIColor(red: 65.0/255.0, green: 117.0/255.0, blue: 5.0/255.0, alpha: 1.0)
    }
    
    func deselectUser(cell:UITableViewCell,indexPath:NSIndexPath){
        let statusImage:UIView = cell.viewWithTag(2)!
        statusImage.backgroundColor = UIColor.whiteColor()
        
        let greenOvalImage:UIImageView = cell.viewWithTag(5)! as! UIImageView
        greenOvalImage.image = UIImage(named: "greenOval")
        
        let label:UILabel = cell.viewWithTag(1) as! UILabel
        label.text = self.crewMembers[indexPath.row]
        label.font = UIFont(name: "Helvetica", size: 18.0)
        label.textColor = UIColor(red: 155.0/255.0, green: 155/255.0, blue: 155.0/255.0, alpha: 1.0)
    }
    
    func cellTouchDown(sender:UIButton){
        if let _ = SinchConnector.sharedInstance.activeCall{
            // End Call
            let cell:UITableViewCell = sender.superview!.superview! as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            
            deselectUser(cell,indexPath:indexPath)
            
            SinchConnector.sharedInstance.endCall()
        }else{
            // Start call
            let cell:UITableViewCell = sender.superview!.superview! as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            
            selectUser(cell,indexPath:indexPath)
            
            let crewUserID = self.crewMembers[indexPath.row]
            SinchConnector.sharedInstance.startCall(crewUserID)
        }
        
    }

}

