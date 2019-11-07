//
//  TabBarViewController.swift
//  conway`sGame
//
//  Created by Cassia Aparecida Barbosa on 31/10/19.
//  Copyright © 2019 teamconwaysGame. All rights reserved.
//

import UIKit
import Foundation

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bronzeViewController = BronzeGVC()
        bronzeViewController.tabBarItem = UITabBarItem(title: "Bronze", image:UIImage(named: "circle") , tag: 0)
//        bronzeViewController.tabBarItem.setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        
        let silverViewController = SilverGVC()
        silverViewController.tabBarItem = UITabBarItem(title: "Silver", image:UIImage(named: "circle") , tag: 1)
        
        let goldViewController = GoldGVC()
        goldViewController.tabBarItem = UITabBarItem(title: "Gold", image:UIImage(named: "circle") , tag: 2)
        
        self.viewControllers = [bronzeViewController, silverViewController, goldViewController]
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
