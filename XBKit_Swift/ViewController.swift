//
//  ViewController.swift
//  XBKit_Swift
//
//  Created by Xinbo Hong on 2018/5/29.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let contentView = UILabel()
        contentView.backgroundColor = UIColor.white
        contentView.textAlignment = .center
        contentView.font = UIFont.systemFont(ofSize: 25)
        contentView.text = "恭喜你刮中500万"
        contentView.numberOfLines = 0
        
        let maskView = UIView()
        maskView.backgroundColor = UIColor.lightGray
        
        let view = ScratchView.init(contentView: contentView, maskView: maskView, percent: 0.7)
        view.strokeLineCap = kCALineCapRound
        view.strokeLineWidth = 25
        view.frame = CGRect.init(x: 33, y: 140, width: 300, height: 154)
        view.addSubview(view)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

