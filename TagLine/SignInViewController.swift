//
//  SignInViewController.swift
//  TagLine
//
//  Created by KIM HO MIN on 7/9/18.
//  Copyright © 2018 HOTO. All rights reserved.
//
import Foundation
import UIKit

class SignInViewController: UIViewController {

    
    
    @IBAction func signup(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "signup", sender: self)
        
        
    }
    
    
    
    @IBOutlet var loginId: UITextField!
    @IBOutlet var loginPassword: UITextField!
 
    

    @IBAction func Cancel(_ sender: Any) {
        self.performSegue(withIdentifier: "Main", sender: self)
    }
    
    
    
    
    @IBAction func login(_ sender: Any) {
        
       
        if (loginId.text?.isEmpty)! {
            
            displayMessage(userMessage: "아이디를 입력하세요")
        
            return
            
        } else if (loginPassword.text?.isEmpty)! {
            
            displayMessage(userMessage: "암호를 입력하세요")
           
            return
            
        }else {
            
            
            let url = "http://localhost:8080/users/login"
            
            let postString = "email=\(loginId.text!)&password=\(loginPassword.text!)"
            
            FirstApi.instance().makeAPICall(url: url, params:postString, method: .POST, success: { (data, response, error, responsedata) in

                // API call is Successfull
                
                let respondata = responsedata
            
                if ((respondata.contains("message"))) {
                    
                    MyDTO().DTO(type: "message", repondata: respondata, userdatas: { (userdatad) in
                        
                        let errormessage = userdatad
                            print("\(errormessage)")
                            self.displayMessage(userMessage: "\(errormessage)")
                            
                            
                        }
                        )
                        
                } else {
                    
                        
                        DispatchQueue.main.async {
                        
                        
                        
                            
                            MyDTO().DTO(type: "email",repondata: respondata, userdatas: { (userdatad) in
                                
                                let useremail = userdatad
                                print("\(useremail)")
                                
                                
                                let IDdata = UserDefaults.standard
                                IDdata.set(useremail, forKey: "logined")
                                
//                                self.presentingViewController?.dismiss(animated:true, completion: nil)
                                
                            }
                                
                            )
                            
                            
                            
                            
                            MyDTO().DTO(type: "name",repondata: respondata, userdatas: { (userdatad) in

                                let username = userdatad
                                print("\(username)")
                                
                                
                                let IDdatas = UserDefaults.standard
                                IDdatas.set(username, forKey: "name")
//                                self.presentingViewController?.dismiss(animated:true, completion: nil)

                            }
                                
                            )
                            
                            self.presentingViewController?.dismiss(animated:true, completion: nil)
                            
                            
                            
                        }
                        
                }

                print("API call is Successfull")
                
            }, failure: { (data, response, error) in
                

                // API call Failure
                print("fail")
            } )
            
//            responseDTO().loginDTO(id: loginId.text!, pass: loginPassword.text!)
//            NSLog("7777777777777777777777")
//
//            var request = URLRequest(url: URL(string: "http://localhost:8080/users/login")!)
//            request.httpMethod = "POST"
//            let postString = "email=\(loginId.text!)&password=\(loginPassword.text!)"
//            request.httpBody = postString.data(using: .utf8)
//
//
//
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("error=\(error! as! String)")
//                return
//            }
//
//            let httpStatus = response as? HTTPURLResponse
//            print("statusCode should be 200, but is \(httpStatus!.statusCode)")
//            print("response = \(response)")
//            print(postString)
//
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString)")
//
//
//
//
//            if (responseString?.contains("message"))! {
//
//
//
//                struct RegisteredUser: Codable {
//                    let message: String
//
//                }
//
//
//                let errordata = responseString?.data(using: .utf8)
//                let decoder = JSONDecoder()
//
//                do {
//                    let user_data = try decoder.decode(RegisteredUser.self, from: errordata!)
//                    print("asdasfd \(user_data)")
//
//
//
//                    self.displayMessage(userMessage: "\(user_data.message)")
//
//                } catch {
//                    print("error on decode: \(error.localizedDescription)")
//
//                }
//
//
//            }
//            else {
//
//                    print("correct good")
//                DispatchQueue.main.async {
//                    let IDdata = UserDefaults.standard
//                    IDdata.set(self.loginId.text!, forKey: "logined")
//                }
//
//
//                self.dismiss(animated:true, completion: nil)
//
//            }
//
//        }
//            task.resume()
            
            
        
        }
        
        
        
   
        
        
        
        
    }
                    
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let controller = storyboard.instantiateInitialViewController()
//                    self.present(controller!, animated: true, completion: nil)
                    
                    
                    
//        let alertfailid = UIAlertController(title: "알림", message: "id 없음", preferredStyle: .alert)
//        let alertfailpass = UIAlertController(title: "알림", message: "pass 틀림", preferredStyle: .alert)
                    
    //        let okAction = UIAlertAction(title: "OK", style: .default){
    //            (alert:UIAlertAction) -> Void in
    //
    //        }
                    

        
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title:"Alert", message: userMessage, preferredStyle:.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)
                { (action:UIAlertAction!) in
                
                    print("Ok button tapped")
//                    DispatchQueue.main.async
//                        {
//                            //                            self.dismiss(animated: true, completion: nil)
//                    }
                }
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                
        }
    }
    
    
    
    //                    let data = data
    //                self.postString = "email=\(self.loginId.text!)&password=\(self.loginPassword.text!)"
    
    //                    self.respondata = String(data: data!, encoding: .utf8)!
    //                    print("respondata = \(self.respondata)")
    
    //                if (self.respondata.contains("message")) {
    //
    //                    MyDTO().DTO(repondata: self.respondata)
    //
    //
    //                } else {
    //
    //
    //                }
    //
    
    
    
    
    
    
    
    
    //        let ud = UserDefaults.standard
    //
    //        let id = ud.object(forKey: "email") as? String
    //        let pass = ud.string(forKey: "pass")
    //        let id = "123"
    
    
    //        let id = MyData().ID
    //        let pass = MyData().Pass
    
    //        let userID = loginId.text
    //        let userPassword = loginPassword.text
    
    
    //        if (userID == id) && (userPassword == pass)  {
    
    //            self.performSegue(withIdentifier: "ManualMenu", sender: self)
    
    
    
    //            let udemail = UserDefaults.standard
    //            udemail.set(self.loginId.text, forKey: "email")
    //
    //            NSLog("emailsaved")
    //            let udpass = UserDefaults.standard
    //            udpass.set(self.loginPassword.text, forKey: "pass")
    //
    //            NSLog("passsaved")
    
    
    
    
    
    //            let storyboards = UIStoryboard(name: "Main", bundle: Bundle.main)
    //
    //            let uvcs = storyboards.instantiateInitialViewController()
    //            uvcs?.modalTransitionStyle = UIModalTransitionStyle.coverVertical
    //
    //            self.present(uvcs!, animated: true)
    
    //        } else if (userID == id){
    //            alertfailpass.addAction(okAction)
    //            present(alertfailpass, animated: true, completion: nil)
    //
    //
    //        } else {
    //            alertfailid.addAction(okAction)
    //            present(alertfailid, animated: true, completion: nil)
    //
    //        }
    
    
    
   
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
