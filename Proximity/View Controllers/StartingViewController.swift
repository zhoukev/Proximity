//
//  StartingViewController.swift
//  Proximity
//
//  Created by Kevin Zhou on 1/16/18.
//  Copyright © 2018 Kevin Zhou. All rights reserved.
//

import Foundation
import UIKit
class StartingViewController:UIViewController{//loading vc

    override func viewDidLoad() {

        self.view.backgroundColor = bgColor
        if StoreLogin.sharedInstance.getUsername() != "" && StoreLogin.sharedInstance.getPassword() != ""{//see if has existing login
            let chatVc = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            loginProcess(username: StoreLogin.sharedInstance.getUsername(), password: StoreLogin.sharedInstance.getPassword(), error: { (err) in
                let transition = CATransition()//error in signing in, goes to sign in vc
                transition.duration = 1
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionFade
                self.navigationController?.view.layer.add(transition, forKey: nil)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
                _ = self.navigationController?.pushViewController(vc!, animated: false)
            }, finished: { (bool) in//logged in, goes to selection vc
                let transition = CATransition()
                transition.duration = 1
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionFade
                self.navigationController?.view.layer.add(transition, forKey: nil)
                let selectionVc = self.storyboard?.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
                _ = self.navigationController?.pushViewController(selectionVc, animated: false)
                StoreViewed.sharedInstance.loggedIn()
            })
        }else{//no existing login, goes to sign in vc
            delay(2){
                let transition = CATransition()
                transition.duration = 1
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionFade
                self.navigationController?.view.layer.add(transition, forKey: nil)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
                _ = self.navigationController?.pushViewController(vc!, animated: false)
            }
        }
    }
}
