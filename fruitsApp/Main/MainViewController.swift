//
//  MainViewController.swift
//  perfume
//
//  Created by Bassam Ramadan on 4/16/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var sideMenu: UIView!
    @IBOutlet var containerViewTrailing: NSLayoutConstraint!
    @IBOutlet var sideMenuTrailing: NSLayoutConstraint!
    
    
    var menuVisible = false
    var tabBarIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        for i in 0..<5{
            AppDelegate.badge[i].removeFromSuperlayer()
            AppDelegate.badge[i] = CAShapeLayer()
            AppDelegate.firstBadge[i] = true
        }
        */
      setup()
    }
    func setup(){
         self.sideMenuTrailing.constant = 0 - self.sideMenu.frame.size.width
    }
    func hideSideMenu() {
        if(menuVisible){
            UIView.animate(withDuration: 0.5, animations: {
                self.sideMenuTrailing.constant = 0 - self.sideMenu.frame.size.width
                // move the content view (tab bar controller) to original position
                self.containerViewTrailing.constant = 0
                self.view.layoutIfNeeded()
            })
            
            menuVisible = !menuVisible
        }
    }
    @objc func toggleSideMenu(fromViewController: UIViewController) {
        if(menuVisible){
            UIView.animate(withDuration: 0.5, animations: {
                // hide the side menu to the left
                self.sideMenuTrailing.constant = 0 - self.sideMenu.frame.size.width
                // move the content view (tab bar controller) to original position
                self.containerViewTrailing.constant = 0
                self.view.layoutIfNeeded()
            })
        } else {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                // move the side menu to the right to show it
                self.sideMenuTrailing.constant = 0
                // move the content view (tab bar controller) to the right
                self.containerViewTrailing.constant =  0 - self.sideMenu.frame.size.width
                self.view.layoutIfNeeded()
            })
        }
        
        menuVisible = !menuVisible
    }

}
