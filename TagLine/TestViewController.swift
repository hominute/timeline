//
//  TestViewController.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/13/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import UIKit


class TestViewController: UIViewController {
    @IBOutlet var content: UITextField!
    
    
    @IBOutlet var ids: UITextField!
    
    
    @IBAction func up(_ sender: Any) {
        
        
       
        let params = [
            "userId": "1",
            "content": "hihi"
            ] as [String : Any]
        
        let url = "http://localhost:8080/timeline"
//        let params = "id=\(ids.text!)&content=\(content.text!)"
        
        SecondApi.instance().makeAPICalls(url: url, params: params, method: .POST, success: { (data, response, error, responsedata) in
        
            
            NSLog("success")
            
            
            
        }
            
            , failure: {(data, response, error) in
                
                NSLog("failure")
                
        }
            
            
            
        )
        
//
//        HttpClientApi.instance().makeAPICall(url: url, params: "", method: .POST, success: { (data, response, error, responsedata) in
//
//
//        NSLog("success")
//
//
//
//        }
//
//            , failure: {(data, response, error) in
//
//                NSLog("failure")
//
//        }
//
//
//
//    )
    
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
