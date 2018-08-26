
//
//  MyPageViewController.swift
//  TagLine
//
//  Created by KIM HO MIN on 7/9/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import UIKit
import Foundation

class MyPageViewController: UIViewController {

    
    @IBOutlet var emailLabel: UILabel!
    
    @IBOutlet var emailInfo: UITextField!
    
    
    @IBOutlet var namelabel: UILabel!
    
    @IBOutlet var nameInfo: UITextField!
    
    
    @IBAction func EditInfo(_ sender: Any) {
        
        
    
    
        
        
        
        let postString = "name=\(nameInfo.text!)"
        let url = "http://localhost:8080/users/info/1?"
        
//        print("sfasdf = \(querystring().)")
        
        
        
        FirstApi.instance().makeAPICall(url: url, params: postString, method: .PUT, success: {(data, response, error, responsedata) in
        
            
            // API call is Successfull
            
            let respondata = responsedata
            
           
            
            if ((respondata.contains("message"))) {
                
                MyDTO().DTO(type: "message", repondata: respondata, userdatas: { (userdatad) in
                    
                    let errormessage = userdatad
                    print("\(errormessage)")
                   
                }
                )
                
            } else {
                
            }
            
            return
            
        }, failure: {(data, response, error) in
            
 
            
        }
            
        )
        
        
    }
    
  
    
    
    
    
    
    
// 로그아웃버튼 만드는 코드
    @IBAction func logout(_ sender: Any) {
        
        let udlogout = UserDefaults.standard
        udlogout.removeObject(forKey: "logined")
        udlogout.removeObject(forKey: "name")
        
        
        self.performSegue(withIdentifier: "Login", sender: self)
        
        
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextView = storyboard.instantiateInitialViewController()
//        self.present(nextView!, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func go(_ sender: Any) {
        
        
        
         self.performSegue(withIdentifier: "Login", sender: self)
      
//        self.performSegue(withIdentifier: "Login", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        
        let ud = UserDefaults.standard
        
        let email = ud.string(forKey: "logined")
        
        if email == nil {
           
            self.performSegue(withIdentifier: "Login", sender: self)
            
        }else{
            
            let uds = UserDefaults.standard
            
            let name = uds.string(forKey: "name")
            let emails = uds.string(forKey: "logined")
            
            self.nameInfo.text = name
            self.emailInfo.text = emails
            
        }
        NSLog("\(email)")
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
