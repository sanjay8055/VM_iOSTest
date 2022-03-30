//
//  HomeViewController.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import UIKit

class HomeViewController: UITabBarController {

    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let apptheme = AppTheme.shared {
            self.tabBar.tintColor = UIColor(hex: apptheme.primaryColor)
        }
    }

}
