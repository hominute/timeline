//
//  CommentTableViewController.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/22/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import UIKit

class CommentTableViewController: UITableViewController {

    var comments: [CommentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(CommentTableViewController.viewRepliesPressed(_:)), name: NOTIF_VIEW_REPLIES_PRESSED, object: nil)

//        comments = DataList().getData()
    }

    
    
    @objc func viewRepliesPressed(_ notif: NSNotification) {
        if let data = notif.userInfo as NSDictionary? {
            if let indexPath = data["indexPath"] as? IndexPath {
                self.tableView.delegate?.tableView!(self.tableView, didSelectRowAt: indexPath)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.comments.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if self.comments[section].isOpen {
            return self.comments[section].replies.count + 1
        } else {
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as? CommentTableViewCell
                let comment = self.comments[indexPath.section]
//                cell.contentView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
            cell?.indexPath = indexPath
            cell?.updateView(comment: comment)
            return cell!
           
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as? CommentTableViewCell
                let comment =  self.comments[indexPath.section].replies[indexPath.row - 1]
//                cell.contentView.layoutMargins = UIEdgeInsetsMake(0, 50, 0, 0)
            cell?.updateView(comment: comment)
            cell?.ButtonViewReplies.isHidden = true
            return cell!
            }
        }    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if self.comments[indexPath.section].isOpen {
                self.comments[indexPath.section].isOpen = false
                let sections = IndexSet.init(integer: indexPath.section)
                self.tableView.reloadSections(sections, with: .none)
            } else {
                self.comments[indexPath.section].isOpen = true
                let sections = IndexSet.init(integer: indexPath.section)
                self.tableView.reloadSections(sections, with: .none)
            }
        }
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
