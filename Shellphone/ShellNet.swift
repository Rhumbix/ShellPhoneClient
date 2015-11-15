//
//  ShellNet.swift
//  Shellphone
//
//  Created by Jonathan Sandness on 11/14/15.
//  Copyright © 2015 sandness. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class ShellNet : NSObject {
    
    private static let API_BASE_URL = "http://localhost:9393"
    
//    private class func shellRequest(verb: Alamofire.Method, uri: String, params: NSDictionary?,
//        successCallback:((result: AnyObject) -> Void)?, failureCallback:((err: NSError) -> Void)?) -> Void {
//            let url = API_BASE_URL + uri
//            
//            // took out: headers: getAuthHeader()
//            Alamofire.request(verb, url, parameters: params as? [String : AnyObject])
//                .responseJSON {
//                    response in
//                    switch response.result {
//                    case .Success:
//                        
//                        if 200...299 ~= response.response!.statusCode {
//                            if successCallback != nil {
//                                successCallback!(result: response.result.value!)
//                            }
////                        } else {
////                            // get the NSError to log
////                            NSLog(response.result.debugDescription)
////                            let error = getNsErrorRepresentation((response.response?.statusCode)!, value: response.result.value!)
////                            
////                            // log the error, locally and through sentry, and call the failure callback if present
////                            NSLog(error.localizedDescription)
////                            //RavenCaptureSwift(error)
////                            if failureCallback != nil {
////                                failureCallback!(err: error)
////                            }
//                        }
//                    case .Failure(let error):
//                        
//                        // log the error, locally and through sentry, and call the failure callback if present
//                        NSLog(error.localizedDescription)
//                        //RavenCaptureSwift(error)
////                        if failureCallback != nil {
////                            failureCallback!(err: getNsErrorRepresentation(error.code, value: nil, errorMessage: error.localizedDescription))
////                        }
//                    }
//                    
//            }
//    }

    class func getUsers() -> Void {
        Alamofire.request(.GET, API_BASE_URL + "/users")
            .responseJSON { response in
                print(response)
//                print(data)
//                print(error)
                switch response.result {
                case .Success:
                    if 200...299 ~= response.response!.statusCode {
                        NSLog("Success get /users")
//                        NSLog(JSON(response.result.value!))
                    } else {
                        NSLog("Fail get /users")
//                        NSLog(JSON(response.result.value!))
                    }
                case .Failure(let error):
                    NSLog("Fail get /users, ERROR!")
                    NSLog(error.localizedDescription)
                    
                }
            }
    }
//    class func getCostCodesForForeman(id: NSInteger, successCallback:(responseObject: AnyObject) -> Void,
//        failureCallback:(err: NSError) -> Void) -> Void {
////             setup the Alamofire (rx) request
//            rxRequest(.GET, uri: "/api/v2/cost_codes/", params: ["foremanId": id], successCallback: successCallback, failureCallback: failureCallback)
//    }
//
//    class func getWorkerStats(id: NSInteger, successCallback:(responseObject: AnyObject) -> Void, failureCallback:(err: NSError) -> Void) -> Void {
//        // setup the Alamofire (rx) request
//        rxRequest(.GET, uri: "/api/v2/users/" + String(id) + "/stats/", params: nil,
//            successCallback: successCallback, failureCallback: failureCallback)
//    }
}