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
    var addEcoTrashController: AddEcoTrashController!
 
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
            
        }
        customTabBarView.frame.size.width = self.view.frame.width
        self.view.addSubview(customTabBarView)

       companyListController = CompanyListController()
        eventListController = EventListController()
        addEcoTrashController = AddEcoTrashController()

//        companyListController.tabBarItem.image = UIImage(named: "company")
//        companyListController.tabBarItem.selectedImage = UIImage(named: "company")
//        eventListController.tabBarItem.image = UIImage(named: "events")
//        eventListController.tabBarItem.selectedImage = UIImage(named: "events")
//        addEcoTrashController.tabBarItem.image = UIImage(named: "add")
//        addEcoTrashController.tabBarItem.selectedImage = UIImage(named: "add")

        viewControllers = [companyListController, eventListController, addEcoTrashController]
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: AddEcoTrashController.self) {
            let vc =  AddEcoTrashController()
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
