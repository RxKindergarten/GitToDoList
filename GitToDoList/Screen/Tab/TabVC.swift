//
//  TabVC.swift
//  GitToDoList
//
//  Created by 이재용 on 2021/04/17.
//

import UIKit

class TabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTab()
    }
    
    private func initializeTab() {
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .black
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.tintColor = .white
        
        guard let issuesVC = UIStoryboard(name: "Issue", bundle: nil)
                .instantiateViewController(identifier: "IssueVC") as? IssueVC else { return }
        guard let repoVC = UIStoryboard(name: "Repo", bundle: nil)
                .instantiateViewController(identifier: "RepoVC") as? RepoVC else { return }
        self.viewControllers = [issuesVC, repoVC]
        let tabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        let tabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        
        myTabBarItem1.image = UIImage(named:"btnHomeUnselected")
        myTabBarItem1.selectedImage = UIImage(named: "btnHomeSelected")
        
        myTabBarItem2.image = UIImage(named:"btnExploreUnselected")
        myTabBarItem2.selectedImage = UIImage(named:"btnExploreSelected")
        
    

    }
}
