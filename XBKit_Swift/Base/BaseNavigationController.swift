//
//  BaseNavigationController.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/7/3.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            
            let button: UIButton = UIButton.init(type: .custom)
            button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
            button.setImage(UIImage.init(named: ""), for: UIControlState.normal)
            button.contentHorizontalAlignment = .left
            button.addTarget(self, action: #selector(backInBaseNavigationController), for: .touchUpInside)
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    @objc func backInBaseNavigationController() {
        self.popViewController(animated: true)
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
