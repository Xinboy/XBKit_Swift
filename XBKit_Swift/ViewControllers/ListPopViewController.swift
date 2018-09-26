//
//  ListPopViewController.swift
//  PlayCardHousekeeper
//
//  Created by Xinbo Hong on 2018/3/28.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

import UIKit

class ListPopViewController: UIViewController {

    private struct Constants {
    
    }
    
    
    var dataSouces: Array<Any>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
    }

    // MARK: - Public
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var tableView: UITableView = {
        var temp = UITableView.init(frame: self.view.bounds, style: .plain)
        
        if #available(iOS 11.0, *) {
            temp.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        temp = UITableView.init(frame: CGRect.zero, style: .plain)
        temp.delegate = self
        temp.dataSource = self
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        temp.rowHeight = 60
        
        return temp
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ListPopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if dataSouces?.count == 0 {
//            return 0
//        } else {
//            return dataSouces!.count
//        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

