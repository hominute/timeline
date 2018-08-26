////
////  getrequest.swift
////  TagLine
////
////  Created by KIM HO MIN on 7/26/18.
////  Copyright © 2018 HOTO. All rights reserved.
////
//
//import Foundation
//
//
//
//
//enum HttpMethod : String {
//    case  GET
//    case  POST
//    case  DELETE
//    case  PUT
//}
////var data: NSData = datas
//
//class HttpClientApi: NSObject{
//    
//    //TODO: remove app transport security arbitary constant from info.plist file once we get API's
//    var request : URLRequest?
//    var session : URLSession?
//    
//    static func instance() ->  HttpClientApi{
//        
//        return HttpClientApi()
//    }
//    
////     func makeAPICall(url: String,params: Dictionary<String, Any>?, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
//    
//    
//    func makeAPICall(url: String, params: Any?, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
//        
//        request = URLRequest(url: URL(string: url)!)
//        
//        print("URL = \(url)")
//        
//        if let params = params {
//            
//            let requestData = params
////            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
//            
//            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request?.httpBody = requestData as? Data//?.base64EncodedData()
//            
//            
//            //paramString.data(using: String.Encoding.utf8)
//        }
//        request?.httpMethod = method.rawValue
//        
//        
////        let configuration = URLSessionConfiguration.default
////
////        configuration.timeoutIntervalForRequest = 30
////        configuration.timeoutIntervalForResource = 30
//        
////        session = URLSession(configuration: configuration)
//        //session?.configuration.timeoutIntervalForResource = 5
//        //session?.configuration.timeoutIntervalForRequest = 5
//        
//        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
//            
//            
//            
//            if let data = data {
//                
//                if let response = response as? HTTPURLResponse, 200...500 ~= response.statusCode {
//                    success(data , response , error as NSError?)
//                    
//                    print("statusCode should be 200, but is \(response.statusCode)")
//                    print("response = \(response)")
//                    
//                    
//                    
//                } else {
//                    
//                    failure(data , response as? HTTPURLResponse, error as NSError?)
//                }
//            }else {
//                
//                
//                failure(data , response as? HTTPURLResponse, error as NSError?)
//                
//            }
//            }.resume()
//        
//    }
//    
//}
