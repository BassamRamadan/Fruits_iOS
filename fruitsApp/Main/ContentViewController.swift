//
//  ContentViewController.swift
//  slideMenuStarter
//
//  Created by Bassam Ramadan on 4/16/20.
//  Copyright © 2020 fluffy. All rights reserved.
//

import UIKit

class ContentViewController: common {
    
    var menuButton: UIButton!
    var notificationsButton: UIButton!
    var setup = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        menuButton = setupButton(imageName: "ic_menu")
        notificationsButton = setupButton(imageName: "ic_cart")
        
        // function performed when the button is tapped
        menuButton.addTarget(self, action: #selector(profileButtonTapped(_:)), for: .touchUpInside)
        notificationsButton.addTarget(self, action: #selector(handleNotifications(_:)), for: .touchUpInside)
        // Add the profile button as the left bar button of the navigation bar
        let Rightbutton = UIBarButtonItem(customView: menuButton)
        self.navigationItem.rightBarButtonItem = Rightbutton
        
        
        let Leftbutton = UIBarButtonItem(customView: notificationsButton)
        self.navigationItem.setLeftBarButton(Leftbutton, animated: true)
        
        
        
        let panGestureRecognizser = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)) )
        
        view.addGestureRecognizer(panGestureRecognizser)
    }
    func setupButton(imageName: String) -> UIButton{
        let MenuButton = UIButton(type: .system)
        MenuButton.setImage(UIImage(named: imageName) , for: .normal)
        MenuButton.contentMode = .scaleAspectFit
        MenuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            MenuButton.widthAnchor.constraint(equalToConstant: 35.0),
            MenuButton.heightAnchor.constraint(equalToConstant: 35.0)
            ])
        
        return MenuButton
    }
    @IBAction func profileButtonTapped(_ sender: Any){
        // current view controller (self) is embed in navigation controller which is embed in tab bar controller
        // .parent means the view controller that has the container view (ie. MainViewController)
        
        if let mainVC = self.navigationController?.parent as? MainViewController {
            mainVC.toggleSideMenu(fromViewController: self)
        }
    }
    @objc func handleNotifications(_ recognizer: UIPanGestureRecognizer){
        if CashedData.getUserApiKey() == ""{
            openRegisteringPage(pagTitle: "login")
        }else{
            let storyboard = UIStoryboard(name: "Cart", bundle: nil)
            let linkingVC = storyboard.instantiateViewController(withIdentifier: "Cart") as! UINavigationController
            linkingVC.modalPresentationStyle = .fullScreen
            self.present(linkingVC, animated: true)
        }
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
    
        // the main view controller that have two container view
        guard let mainVC = self.navigationController?.parent as? MainViewController else {
            return
        }
        
        // when user lift up finger / end drag
        if(recognizer.state == .ended || recognizer.state == .failed || recognizer.state == .cancelled){
            
            if(mainVC.menuVisible){
                // user finger moved to left before ending drag
                if(translation.x > 0){
                    // toggle side menu (to fully hide it)
                    mainVC.toggleSideMenu(fromViewController: self)
                }
            } else {
                // user finger moved to right and more than 100pt
                if(translation.x < (0 - 100.0)){
                    // toggle side menu (to fully show it)
                    mainVC.toggleSideMenu(fromViewController: self)
                } else {
                    // user finger moved to right but too less
                    // hide back the side menu (with animation)
                    mainVC.view.layoutIfNeeded()
                    UIView.animate(withDuration: 0.5, animations: {
                        mainVC.sideMenuTrailing.constant = 0 - mainVC.sideMenu.frame.size.width
                        mainVC.containerViewTrailing.constant = 0
                        mainVC.view.layoutIfNeeded()
                    })
                }
            }
            
            // early return so code below won't get executed
            return
        }
        
        
        if(!mainVC.menuVisible && translation.x < 0.0 && translation.x >= (0 - mainVC.sideMenu.frame.size.width)) {
            mainVC.sideMenuTrailing.constant =  0 - (mainVC.sideMenu.frame.size.width + translation.x)
            
            mainVC.containerViewTrailing.constant =  translation.x
        }
        
        if(mainVC.menuVisible && translation.x <= mainVC.sideMenu.frame.size.width && translation.x > 0.0) {
            mainVC.sideMenuTrailing.constant =  0 - translation.x
            
            mainVC.containerViewTrailing.constant = 0 - (mainVC.sideMenu.frame.size.width + mainVC.sideMenuTrailing.constant)
        }

    }
    func getCartItems(id:Int){
        getCartItems{
            (data) in
            self.notificationsButton.addBadge(id: id, number: data?.items?.count ?? 0, withOffset: CGPoint(x: -6, y: -3), andBackgroundColor: .red, strokeColor: UIColor.white, textColor:
                UIColor.white)
        }
    }
}
