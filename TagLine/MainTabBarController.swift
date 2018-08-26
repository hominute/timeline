//
//  MainTabBarController.swift
//  TagLine
//
//  Created by KIM HO MIN on 8/23/18.
//  Copyright © 2018 HOTO. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    
    
    

    
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        
        
        if tabBarController.selectedIndex == 2 {
            
            let cameraController = PhotoCollectionViewController()
            present(cameraController, animated: true, completion: nil)
            // present your first view controller
        }
        
        
        
        
        
//        
//        if viewController is YourViewController {
//            if let newVC = tabBarController.storyboard?.instantiateViewController(withIdentifier: "YourVCStoryboardIdentifier") {
//                tabBarController.present(newVC, animated: true)
//                return false
//            }
//        }
        
        return true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        

        
  
        view.backgroundColor = .blue

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
