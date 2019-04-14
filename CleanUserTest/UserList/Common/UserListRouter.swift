//
//  UserListRouter.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation
import UIKit

struct UserListRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension UserListRouter: UserListRoutable {
    func goToUserDetail(with user: UserObject) {
        let identifier = String(describing: UserDetailsVC.self)
        guard let userDetailsVC = UIViewController.vc(
            "Main",
            identifier: identifier
            ) as? UserDetailsVC else { return }
        
        userDetailsVC.viewModel.inputs.configure(user: user)
        viewController?.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}
