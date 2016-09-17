//
//  ViewController.swift
//  gameofchats
//
//  Created by 周大剛 on 2016/9/10.
//  Copyright © 2016年 周大剛. All rights reserved.
//

import UIKit
import Firebase


// 使用UITable!!
class ViewController: UITableViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 建立一個左上角的logoutButton，非常神奇啊！
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",style: .Plain, target: self, action: #selector(handleLogout))
    }

    func handleLogout(){
        // 按下"Logout" button時，則跳到Login ViewCOntroller!
        let loginController = LoginController()
        presentViewController(loginController, animated: true, completion: nil)
    }

}

