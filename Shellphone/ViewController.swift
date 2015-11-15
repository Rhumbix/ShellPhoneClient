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
    
    var crewMembers:[String] = ["Jon","George","Cameron"]
    
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
            SinchConnector.sharedInstance.setupSinch(username)
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
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        print("Touch down")
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        print("Touch up")
    }
    

}

