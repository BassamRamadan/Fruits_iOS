//
//  ViewController.swift
//  ios-swift-collapsible-table-section-in-grouped-section
//
//  Created by Yong Su on 5/31/16.
//  Copyright © 2016 Yong Su. All rights reserved.
//
import UIKit
class menuController: common{
    // MARK: - Outlets
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionHeight: NSLayoutConstraint!

    @IBOutlet var logout: UIButton!
    @IBOutlet var login: UIButton!
    @IBOutlet var signup: UIButton!
    
    var categories: [brandItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appendList()
    }
    fileprivate func appendList(){
        signup.isHidden = CashedData.getUserApiKey() != ""
        login.isHidden = CashedData.getUserApiKey() != ""
        logout.isHidden = CashedData.getUserApiKey() == ""
        
        if CashedData.getUserApiKey() == ""{
            categories.append(brandItem(brandText: "الرئيسية", brandImage: #imageLiteral(resourceName: "ic_home"),storyName: "Main"))
            categories.append(brandItem(brandText: "مشاركة التطبيق", brandImage: #imageLiteral(resourceName: "ic_share"),storyName: "Share"))
            categories.append(brandItem(brandText: "حول التطبيق", brandImage: #imageLiteral(resourceName: "ic_about"),storyName: "aboutUs"))
            categories.append(brandItem(brandText: "تواصل معنا", brandImage: #imageLiteral(resourceName: "ic_contact"),storyName: "contactUs"))
        }else{
            categories.append(brandItem(brandText: "الرئيسية", brandImage: #imageLiteral(resourceName: "ic_home"),storyName: "Main"))
            categories.append(brandItem(brandText: "طلبات الشراء", brandImage: #imageLiteral(resourceName: "ic_orders"),storyName: "myOrders"))
            categories.append(brandItem(brandText: "تعديل بياناتي", brandImage: #imageLiteral(resourceName: "ic_edit"),storyName: "sign"))
            categories.append(brandItem(brandText: "مشاركة التطبيق", brandImage: #imageLiteral(resourceName: "ic_share"),storyName: "Share"))
            categories.append(brandItem(brandText: "حول التطبيق", brandImage: #imageLiteral(resourceName: "ic_about"),storyName: "aboutUs"))
            categories.append(brandItem(brandText: "تواصل معنا", brandImage: #imageLiteral(resourceName: "ic_contact"),storyName: "contactUs"))
        }
        updateConstraints()
    }
    func updateConstraints() {
        categoryCollectionView.layoutIfNeeded()
        categoryCollectionHeight.constant = categoryCollectionView.contentSize.height
    }
    @IBAction func registerationButtons(sender: UIButton){
        if sender.tag == 1{
            AdminLogout(currentController: self)
        }else{
            openRegisteringPage(pagTitle: sender.tag == 3 ? "sign" : "login")
        }
    }
}
extension menuController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! categoryCell
        cell.name.text = categories[indexPath.row].brandText
        cell.image.image = categories[indexPath.row].brandImage
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        openPages(row: categories[indexPath.row].storyName)
    }
    
    
    func openPages(row: String){
        switch row {
        case "sign":
            openRegisteringPage(pagTitle: "sign")
            break
        case "Main":
            openMain()
            break
        case "Share":
            share()
            break
        default:
            callStoryboard(name: row)
        }
    }
    func share(){
        let activityController = UIActivityViewController(activityItems: [AppDelegate.stringWithLink], applicationActivities: nil)
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            navigationItem.setLeftBarButton(UIBarButtonItem(customView: UIButton()), animated: false)
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [AppDelegate.stringWithLink], applicationActivities: nil)
            present(activityVC, animated: true)
            if let popOver = activityVC.popoverPresentationController {
                popOver.barButtonItem = navigationItem.leftBarButtonItem
                //popOver.barButtonItem
            }
            
        } else {
            present(activityController, animated: true)
        }
    }
}
struct brandItem {
    
    var brandText:String
    var brandImage:UIImage
    var storyName: String
}
