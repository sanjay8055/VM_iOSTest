//
//  AlertHelper.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 04/04/22.
//

import UIKit

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

func showAlertWithCompletion(message:String,okTitle:String,cancelTitle:String?,completionBlock:@escaping (_ okPressed:Bool)->()){
    let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: okTitle, style: .default) { (ok) in
        completionBlock(true)
    }
    alertController.addAction(okAction)
    if let cancelTitle = cancelTitle{
        let cancelOption = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (axn) in
            completionBlock(false)

        })
        alertController.addAction(cancelOption)
    }

    if let topController = UIApplication.getTopViewController() {
        topController.present(alertController, animated: true) {
            
        }
    }

}
