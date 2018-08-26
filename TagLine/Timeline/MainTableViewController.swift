//
//  MainTableViewController.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/17/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    
    

    let heightOfheader : CGFloat = 44
    

    lazy var list: [MyData] = {
        var datalist = [MyData]()
        
        
        return datalist
        
    }()
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        https://dry-eyrie-61502.herokuapp.com/
      
        
        let url = "https://dry-eyrie-61502.herokuapp.com/timelines?page=0&size=100"
        
//        let postString = ""
        
        FirstApi.instance().makeAPICall(url: url, params:"", method: .GET, success: { (data, response, error, responsedata) in
            
            //             API call is Successfull
            
            guard let data = data else {
                print("request failed \(error)")
                return
            }
            
            do {
                
                let apidata = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                
                let timeline = apidata["timeLines"] as! NSDictionary
                let content = timeline["content"] as! NSArray
                //                let images = content!["image"] as! NSArray
                
                for row in content {
                    
                    
                    let r = row as! NSDictionary
                    
                    let md = MyData()
                    
                    md.ID = r["content"] as? String
                    
                    let images = r["images"] as? NSArray
                   
                    
                    if images?.count != 0 {
                    
                        
                        for row in images! {
                           
                            let r = row as! NSDictionary
                            
                            
                            md.Imagehost = r["fileHost"] as? String
                            md.Imagepath = r["filePath"] as? String
                            md.Imagename = r["fileName"] as? String
                            
                            md.Image = "\(md.Imagehost!)\(md.Imagepath!)\(md.Imagename!)" as? String
//                            md.Image = "https://www.google.co.kr/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
                            
                            print("ggg = \(md.Image!)")
                            
                        }
                    } else  {
                        
                        md.Image = "" as? String
                        print("null image = \(md.Image!)")
                    }
                    
                    
                    let comments = r["comments"] as? NSArray
                    
                    
                    if comments != nil {
                        
                        for row in comments! {
                        
                        
                        let r = row as! NSDictionary
                       
                        
                        md.Comment = r["content"] as? String
                        
                        
                        print("댓글있음은? \(md.Comment!)")
                        
                    }
                    }else{
                        
                        md.Comment = "" as? String
                        
                        print("댓글없음은? \(md.Comment!)")
                    }
//                    else if images == nil {
                    
                        
//                        md.Image? = nil
//
//
//
//                    }
//
                    print("\(self.list.count)")
                    self.list.append(md)
                    
                    
                    DispatchQueue.main.async {
                        
//                        self.tableView.estimatedRowHeight = 500
//                        self.tableView.rowHeight = UITableViewAutomaticDimension
                        self.tableView.reloadData()
                        
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        self.navigationController?.navigationBar.layerWillDraw(
        self.tableView.reloadData()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let uds = UserDefaults.standard
        
        let name = uds.string(forKey: "name")
        
        
        if name == nil {
            
            navigationItem.title = "Timeline"
        } else {
            
            navigationItem.title = name
        }
        

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }

    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTimelineCell", for: indexPath) as! MainTableViewCell
        
        
        let row = self.list[indexPath.row]
        let imageurl = row.Image
        let comment = row.Comment
        
        cell.timelineContentText.text = row.ID
        cell.timelineContentText.numberOfLines = 0
//        cell.timelineUsernameLabel.text = "hahasdfasdfasdfalskdfj;alsdkja"
        cell.timelineUsernameLabel.numberOfLines = 0
        
        
        if comment != "" as? String{
            
            cell.timelineComment.text = comment
            print("셀의 코멘트 = \(comment)")
        } else {
            
            cell.timelineComment.text = "nocomment"
            
        }
       
        if imageurl != "" as? String {
        cell.timelineContentImage?.isHidden = false
        cell.timelineContentImage?.layer.borderWidth = 2
        cell.imageLoad(url: imageurl! as String)
        print("rendered image url = \(imageurl!)")

        } else {
            cell.timelineContentImage?.isHidden = true
        print("empty image url = \(imageurl!)")
        }
        
        if (cell.numberOflikes == 1 || cell.numberOflikes == 0) {
            
            cell.likeLabel.text = "\(cell.numberOflikes) like"
        
        } else {
            
            cell.likeLabel.text = "\(cell.numberOflikes) likes"
        }
        
 
      
        DispatchQueue.main.async {
            
       
            let ud = UserDefaults.standard
            
            let email = ud.string(forKey: "logined")
            
            if email == nil {
                
                cell.timelineUsernameLabel.text = "Anyone"
                
            }else{
                
                let uds = UserDefaults.standard
                
                let name = uds.string(forKey: "name")
                //            let emails = uds.string(forKey: "logined")
                
                cell.timelineUsernameLabel.text = name
                
                
            }
            
            
        }
        
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
