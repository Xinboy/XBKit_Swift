//
//  BasedTabBarViewController.swift
//  IKE-Swift
//
//  Created by Xinbo Hong on 2018/1/23.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit
class BasedTabBarViewController: UITabBarController, UITabBarControllerDelegate{

    struct ItemParameter {
        static let Sight = ["Title":"test",
                            "DefaultImage":"test",
                            "SeletedImage":"test"]

    }
    
    var midTabbar = MidProminentTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.delegate = self;
        self.addChildViewControllers()
    }
    
    
    /****************** 私有方法 ******************/
    private func addChildViewControllers() {
        
        //图片大小建议32*32
        self.addChildNav(vc: ViewController(), title: "tab1", imageName: "tab1_n", selectedImageName: "tab1_p")
        self.addChildNav(vc: ViewController(), title: "tab2", imageName: "tab1_n", selectedImageName: "tab1_p")
        //**中间这个不设置东西，只占位
        //中间突出的按钮，如果不需要注释即可
        midTabbar = MidProminentTabBar.init(frame: CGRect.zero)
        midTabbar.midButton.addTarget(self, action: #selector(onMidButtonClick(sender:)), for: .touchUpInside)
        midTabbar.isTranslucent = false
        self.setValue(midTabbar, forKey: "tabBar")
        self.addChildNav(vc: ViewController(), title: "tab3", imageName: "", selectedImageName: "")
        
        self.addChildNav(vc: ViewController(), title: "tab4", imageName: "tab1_n", selectedImageName: "tab1_p")
        self.addChildNav(vc: ViewController(), title: "tab5", imageName: "tab1_n", selectedImageName: "tab1_p")
    }
    
    private func addChildNav(vc: UIViewController,
                             title: String,
                             imageName: String,
                             selectedImageName: String) {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage.init(named: imageName)
        let selectedImage = UIImage.init(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = selectedImage
        
        let nav = UINavigationController.init(rootViewController: vc)
        self.addChildViewController(nav)
    }
    
    @objc func onMidButtonClick(sender: UIButton) {
        self.selectedIndex = 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
