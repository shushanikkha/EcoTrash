//
//  CustomTabBarController.swift
//  EcoTrash
//
//  Created by Shushan Khachatryan on 9/7/19.
//  Copyright © 2019 Shushan Khachatryan. All rights reserved.
//
import UIKit

class CustomTabBarController:  UITabBarController, UITabBarControllerDelegate {
    @IBOutlet var customTabBarView: UIView!
    
    var companyListController: CompanyListController!
    var eventListController: EventListController!
    var addEcoTrashController: AddEcoTrashTableViewController!
    var newsFeedController: NewsFeedTableViewController!
    var reuseTrashTypeList: ReuseTrashTypeList!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
            
        }
    //    customTabBarView.frame.size.width = self.view.frame.width
        customTabBarView.frame = CGRect(x: 0, y: view.frame.height - 100, width: view.frame.width, height: 100)
        self.view.addSubview(customTabBarView)

       companyListController = CompanyListController()
        eventListController = EventListController()
        addEcoTrashController = AddEcoTrashTableViewController()

//        companyListController.tabBarItem.image = UIImage(named: "company")
//        companyListController.tabBarItem.selectedImage = UIImage(named: "company")
//        eventListController.tabBarItem.image = UIImage(named: "events")
//        eventListController.tabBarItem.selectedImage = UIImage(named: "events")
//        AddEcoTrashTableViewController.tabBarItem.image = UIImage(named: "add")
//        AddEcoTrashTableViewController.tabBarItem.selectedImage = UIImage(named: "add")

//        viewControllers = [companyListController, AddEcoTrashTableViewController, eventListController]
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: AddEcoTrashTableViewController.self) {
            let vc =  AddEcoTrashTableViewController()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    @IBAction func selectedButtonTapped(_ sender: UIButton) {
        self.selectedIndex = sender.tag
    }
    
}
