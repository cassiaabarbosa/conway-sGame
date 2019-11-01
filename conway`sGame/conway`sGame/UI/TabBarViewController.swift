//
//  TabBarViewController.swift
//  conway`sGame
//
//  Created by Cassia Aparecida Barbosa on 31/10/19.
//  Copyright © 2019 teamconwaysGame. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let bronzeViewController = BronzeGVC()
        bronzeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let silverViewController = SilverGVC()
        silverViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        
        let goldViewController = GoldGVC()
        goldViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites , tag: 2)
        
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
