//
//  UserDetailsRouter.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation
import UIKit

struct UserDetailsRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension UserDetailsRouter: UserDetailsRoutable {
    func backToUserList() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
