//
//  getrequest.swift
//  TagLine
//
//  Created by KIM HO MIN on 7/26/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import Foundation


enum HttpMethods : String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}
//var data: NSData = datas

class SecondApi: NSObject{
    
    //TODO: remove app transport security arbitary constant from info.plist file once we get API's
    var request : NSMutableURLRequest?
    var session : URLSession?
    
    
    static func instance() ->  SecondApi{
        
        return SecondApi()
    }
    
    //         func makeAPICall(url: String,params: Dictionary<String, Any>?, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
    
    func makeAPICalls(url: String, params: [String : Any] , method: HttpMethods, success:@escaping ( Data? ,HTTPURLResponse?  , NSError?, String ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
        
        
        //        let headers = [
        //            "Content-Type": "application/x-www-form-urlencoded",
        //            "Cache-Control": "no-cache"
        //        ]
        //
        
        let headers = [
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Postman-Token": "6cb8494b-b87b-4287-9ecf-878c87b40e4e"
        ]
        
        
        let requestData = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        
        request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        
        request?.allHTTPHeaderFields = headers
        //           request?.setValue("application/jsonapplication/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //            URLRequest(url: URL(string: url)!)
        
        print("URL = \(url)")
        
        print("params = \(params)")
        
        
        request?.httpMethod = method.rawValue
        
        
        //        let  requestData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        //        let requestData = NSMutableData(data: (params .data(using: String.Encoding.utf8)!))
        
        //        params
        NSLog("\(requestData)")
        print("requestdata = \(requestData)")
        
        request?.httpBody = requestData as Data
        
        
        //            requestData.data(using: String.Encoding.utf8)//?.base64EncodedData()
        
        
        
        
        //            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        //?.base64EncodedData()
        
        //            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        session = URLSession(configuration: configuration)
        //paramString.data(using: String.Encoding.utf8)
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            
            if let data = data {
                
                if let response = response as? HTTPURLResponse, 200...500 ~= response.statusCode {
                    print("second requestdata = \(requestData)")
                    print("statusCode should be 200, but is \(response.statusCode)")
                    print("response = \(response)")
                    
                    let responsedata = String(data: data, encoding: .utf8)!
                    print("response data = \(responsedata)")
                    
                    success(data , response , error as NSError?, responsedata)
                    print("third requestdata = \(requestData)")
                    
                    
                    
                    
                } else {
                    
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                    
                    print("Fail")
                }
            }
            
            }.resume()
        
    }
    
    //        let configuration = URLSessionConfiguration.default
    //
    //        configuration.timeoutIntervalForRequest = 30
    //        configuration.timeoutIntervalForResource = 30
    
    //        session = URLSession(configuration: configuration)
    //session?.configuration.timeoutIntervalForResource = 5
    //session?.configuration.timeoutIntervalForRequest = 5
    
}
