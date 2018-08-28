//
//  MessageViewController.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/26/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import UIKit
import StompClientLib

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StompClientLibDelegate{
    
    
    
    
    
    var socketClient = StompClientLib()
    
    @IBOutlet var inputMessage: UITextField!
    
    @IBAction func sendMessage(_ sender: Any) {
        
        if inputMessage.text != "" {
            
            
            let bodyString = [
                "message": "\(inputMessage.text! as String)",
                "roomId": "3",
                "userId": "1"
                ] as [String : Any]

            
            
            let url = "https://dry-eyrie-61502.herokuapp.com/chats"
            let message = MessageData(messageType: "MY", userId: "1", message: self.inputMessage.text)
            SecondApi.instance().makeAPICalls(url: url, params: bodyString, method: .POST, success: {(data, response, error, responsedata) in
                // API call is Successfull
                
                let respondata = responsedata
                
                 DispatchQueue.main.async {
                    
                
                    
                    
                if ((respondata.contains("message"))) {

                    MyDTO().DTO(type: "message", repondata: respondata, userdatas: { (userdatad) in

                        let errormessage = userdatad
                        print("\(errormessage)")
                        self.displayMessage(userMessage: "\(errormessage)")

                    }
                    )

                } else {
                    
                    self.list.append(message)
                    self.tableView.reloadData()
                    self.scrollToBottom()
                }
                }
                
                return
                
            }, failure: {(data, response, error) in
                
            }
                
            )
            
           
        }
        
        
        
        
        
        inputMessage.text = ""
    }
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            
            let indexPath = IndexPath(row:self.list.count - 1,section: 0)
            
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            
        }
        
    }
    
    @IBOutlet var tableView: UITableView!
    
    
    lazy var list: [MessageData] = {
        var datalist = [MessageData]()
        datalist.append(MessageData(messageType: "other", userId: "2", message: "this is other message 1 "))

        
        return datalist
        
    }()
    
    
///// Cycle func Start
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let urls = NSURL(string: "wss://dry-eyrie-61502.herokuapp.com/timeline-chat/websocket")!
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: urls as URL) , delegate: self as StompClientLibDelegate)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Message"
        
        let url = "https://dry-eyrie-61502.herokuapp.com/chats?roomId=3&userId=1&page=0&size=1000"
        
        FirstApi.instance().makeAPICall(url: url, params:"", method: .GET, success: { (data, response, error, responsedata) in

            //             API call is Successfull

            guard let data = data else {
                print("request failed \(error)")
                return
            }

            do {
                let apidata = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary

                let content = apidata["content"] as! NSArray

                for row in content {

                    let r = row as! NSDictionary

                    let md = MessageData(messageType: "", userId: "", message: "")
                    
                    md.message = r["message"] as? String
                    md.messageType = r["chatType"] as? String
                    md.userId = r["userId"] as? String

                    print("\(self.list.count)")
                    self.list.append(md)

                    DispatchQueue.main.async {

                        self.tableView.reloadData()
                        self.scrollToBottom()

                    }
                        
                    
                    
                }
            }
            catch  {

            }
            print("API call is Successfull")

        }, failure: { (data, response, error) in


            // API call Failure
            print("fail")
        } )

       
        tableView.dataSource = self
        tableView.delegate = self
        scrollToBottom()
        
        
       
     
        
        
        

    }
    
    
    
    
//Cycle func End
    

// StormClient Delegate Start
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, withHeader header: [String : String]?, withDestination destination: String) {
        print("Destination : \(destination)")
        print("JSON Body : \(String(describing: jsonBody))")
    }
    
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTIONATION : \(destination)")
        print("String JSON BODY : \(String(describing: jsonBody))")
        
        let message = jsonBody
        let data = message?.data(using: String.Encoding.utf8)

        
        do{
                let messagedatas = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
  
            
                    let md = MessageData(messageType: "", userId: "", message: "")
            
            let messageTypes = messagedatas["chatType"] as? String
            
            print("messageType = \(messageTypes!)")
            
            if messageTypes != "MY" {
            
                    md.message = messagedatas["message"] as? String
                    md.messageType = messagedatas["chatType"] as? String
                    md.userId = messagedatas["userId"] as? String
            
                            self.list.append(md)
            
                            DispatchQueue.main.async {
            
                                self.tableView.reloadData()
                                print("\(self.list.count)")
                            }
            }
            
        }catch{
            print("error")
        }
        
        
        }

        
    
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected")
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("Socket is connected")
        
        socketClient.subscribe(destination: "/topic/3")
        // Stomp subscribe will be here!
//        socketClient.subscribe(destination: topic)
        // Note : topic needs to be a String object
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error Send : \(String(describing: message))")
    }
    
    func serverDidSendPing() {
        print("Server ping")
    }
    
    
    
//StormClient Delegate End
    
    
    

//Table View func Start

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let messageData = list[indexPath.row]
    
    if messageData.messageType == "MY"  {
        
       return getMyMessageCell(messageData: messageData, indexPath: indexPath)
        
        
        
        
    }else{
        
      
        return getOtherMessageCell(messageData: messageData, indexPath: indexPath)
        
        }
    
    }
    
    
    func getMyMessageCell (messageData: MessageData, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.message.text = messageData.message
        cell.message.sizeToFit()
        cell.message.numberOfLines = 0
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
        
    }
    
    func getOtherMessageCell (messageData: MessageData, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTableViewCell", for: indexPath) as! OtherTableViewCell
        
        cell.message.text = messageData.message
        cell.message.sizeToFit()
        cell.message.numberOfLines = 0
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
        
    }
    
    
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

 //Table View func End
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title:"Alert", message: userMessage, preferredStyle:.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                          
                    }
                }
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                
                
        }
    }
  
}
