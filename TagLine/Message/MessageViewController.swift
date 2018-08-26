//
//  MessageViewController.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/26/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    
    @IBOutlet var inputMessage: UITextField!
    
    @IBAction func sendMessage(_ sender: Any) {
        
        if inputMessage.text != "" {
            
            
           let message = MessageData(messageType: "my", userId: "1", message: inputMessage.text)
            
            list.append(message)
            tableView.reloadData()
       
            scrollToBottom()
        }
        
        
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
        datalist.append(MessageData(messageType: "other", userId: "2", message: "this is other message 2 "))
        datalist.append(MessageData(messageType: "my", userId: "1", message: "this is my message 1 "))
        datalist.append(MessageData(messageType: "other", userId: "2", message: "this is other message 3 "))
        datalist.append(MessageData(messageType: "my", userId: "1", message: "this is my message 2 "))
        datalist.append(MessageData(messageType: "other", userId: "2", message: "this is other message 1 "))
        datalist.append(MessageData(messageType: "other", userId: "2", message: "this is other message 2 "))
        datalist.append(MessageData(messageType: "my", userId: "1", message: "this is my message 1 "))
        datalist.append(MessageData(messageType: "other", userId: "2", message: "this is other message 3 "))
        datalist.append(MessageData(messageType: "my", userId: "1", message: "this is my message 2 "))
        datalist.append(MessageData(messageType: "other", userId: "2", message: "this is other message 1 "))
        datalist.append(MessageData(messageType: "other", userId: "2", message: "this is other message 2 "))
        datalist.append(MessageData(messageType: "my", userId: "1", message: "this is my message 1 "))
        datalist.append(MessageData(messageType: "other", userId: "2", message: "this is other message 3 "))
        datalist.append(MessageData(messageType: "my", userId: "1", message: "this is my message 2 "))
        
        
        return datalist
        
    }()
    
    
      
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        scrollToBottom()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let messageData = list[indexPath.row]
    
    if messageData.messageType == "my"  {
        
       return getMyMessageCell(messageData: messageData, indexPath: indexPath)
        
        
        
        
    }else{
        
      
        return getOtherMessageCell(messageData: messageData, indexPath: indexPath)
        
    }
    
    
    }
    
    func getMyMessageCell (messageData: MessageData, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.message.text = messageData.message
        
        return cell
    }
    
    func getOtherMessageCell (messageData: MessageData, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTableViewCell", for: indexPath) as! OtherTableViewCell
        
        cell.message.text = messageData.message
        
        return cell
    }
    
    
    
    
    
    
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
  
}
