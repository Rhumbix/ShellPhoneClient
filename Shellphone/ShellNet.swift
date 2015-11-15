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
    
    private static let API_BASE_URL = "http://shellphoneserver.herokuapp.com"
    
    private class func getNsErrorRepresentation(code: Int, value: AnyObject?, errorMessage: String? = nil) -> NSError {
        var errorValue: String
        
        // if a error meassage was passed in, just use that
        if errorMessage != nil {
            errorValue = errorMessage!
        } else {
            // attempt to parse the error object returned from the server
            if let et = JSON(value!)["error"].string {
                errorValue = et
            } else if let et = JSON(value!)["detail"].string {
                errorValue = et
            } else {
                errorValue = "Unknown error - please contact a Rhumbix admin"
            }
        }
        
        let errDict: NSMutableDictionary = NSMutableDictionary()
        errDict.setObject(errorValue, forKey: NSLocalizedFailureReasonErrorKey)
        
        let error: NSError = NSError.init(domain: API_BASE_URL, code: code, userInfo: errDict as [NSObject : AnyObject])
        return error
    }
    
    private class func shellRequest(verb: Alamofire.Method, uri: String, params: NSDictionary?,
        successCallback:((result: AnyObject) -> Void)?, failureCallback:((err: NSError) -> Void)?) -> Void {
            let url = API_BASE_URL + uri
            
            Alamofire.request(verb, url, parameters: params as? [String : AnyObject])
                .responseJSON {
                    response in
                    switch response.result {
                    case .Success:
                        
                        if 200...299 ~= response.response!.statusCode {
                            if successCallback != nil {                              
                                successCallback!(result: response.result.value!)
                            }
                        } else {
                            NSLog(response.result.debugDescription)
                            let error = getNsErrorRepresentation((response.response?.statusCode)!, value: response.result.value!)
                            NSLog(error.localizedDescription)
                            if failureCallback != nil {
                                failureCallback!(err: error)
                            }
                        }
                    case .Failure(let error):
                        NSLog(error.localizedDescription)

                        if failureCallback != nil {
                            failureCallback!(err: getNsErrorRepresentation(error.code, value: nil, errorMessage: error.localizedDescription))
                        }
                    }
                    
            }
    }

    class func getUsers(successCallback:(responseObject: AnyObject) -> Void,
        failureCallback:(err: NSError) -> Void) -> Void {
            shellRequest(.GET, uri: "/users", params: nil, successCallback: successCallback, failureCallback: failureCallback)
            
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