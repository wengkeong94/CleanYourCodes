//
//  UIViewController+SB.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import UIKit

extension UIViewController {
    static func vc(_ storyboard: String, identifier: String?) -> UIViewController {
        let storyBoardInstance = UIStoryboard(name: storyboard, bundle: nil)
        
        if let _identifier = identifier {
            return storyBoardInstance.instantiateViewController(
                withIdentifier: _identifier
            )
        } else {
            return storyBoardInstance.instantiateInitialViewController()!
        }
    }
}
