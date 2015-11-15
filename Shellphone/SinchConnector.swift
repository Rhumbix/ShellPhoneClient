//
//  SinchConnector.swift
//  Shellphone
//
//  Created by Jonathan Sandness on 11/14/15.
//  Copyright © 2015 sandness. All rights reserved.
//

import Foundation

class SinchConnector:NSObject,SINClientDelegate,SINCallDelegate,SINCallClientDelegate{
    static let sharedInstance = SinchConnector()
    
    var sinchClient:SINClient?
    var conferenceID:String = "team"
    
    override init(){
        super.init()
    }
    
    func clientDidStart(client: SINClient!) {
        print("clientDidStart")
        client.callClient().delegate = self
    }
    
    func clientDidStop(client: SINClient!) {
        print("clientDidStop")
    }
    
    func clientDidFail(client: SINClient!, error: NSError!) {
        print("clientDidFail - %@",error)
    }
    
    func callDidProgress(call: SINCall!) {
        print("callDidProgress")
    }
    
    func callDidEstablish(call: SINCall!) {
        print("callDidEstablish")
    }
    
    func client(client: SINCallClient!, didReceiveIncomingCall call: SINCall!) {
        print("did receive incoming call")
        call.answer()
    }
    
    func client(client: SINCallClient!, localNotificationForIncomingCall call: SINCall!) -> SINLocalNotification! {
        print("local Notification")
        return SINLocalNotification()
    }
    
    func client(client: SINClient!, requiresRegistrationCredentials registrationCallback: SINClientRegistration!) {
        print("requiresRegistrationCredentials")
    }
    
    func client(client: SINClient!, logMessage message: String!, area: String!, severity: SINLogSeverity, timestamp: NSDate!) {
        if severity == .Info || severity == .Warn{
            //print(message)
        }
    }
    
    
    
    func setupSinch(username:String){
        print("setupSinch:",username)
        
        self.sinchClient = Sinch.clientWithApplicationKey("6d11b5fd-d4f4-4082-856a-83552da692e4", applicationSecret: "BMK/HNE+8UmztffFLN5MsA==", environmentHost: "sandbox.sinch.com", userId: username)
        self.sinchClient!.delegate = self
        
        sinchClient!.setSupportCalling(true)
        sinchClient!.setSupportActiveConnectionInBackground(true)
        
        self.sinchClient!.start()
        self.sinchClient!.startListeningOnActiveConnection()
    }
    
    func startConference(){
        let call:SINCall = sinchClient!.callClient().callConferenceWithId(conferenceID)
        self.sinchClient!.callClient().delegate = self
        call.delegate = self
        //callClient.callConferenceWithId(conferenceID)
    }
    
    func startCall(username:String){
        let call:SINCall = sinchClient!.callClient().callUserWithId(username)
        self.sinchClient!.callClient().delegate = self
        call.delegate = self
    }
    
}



