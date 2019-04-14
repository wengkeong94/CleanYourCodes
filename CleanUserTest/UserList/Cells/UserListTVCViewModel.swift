//
//  UserListTVCViewModel.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation
import UIKit

protocol UserListTVCViewModelInputs {
    func configure(user: UserObject)
}

protocol UserListTVCViewModelOutputs {
    var title: Box<String?> { get }
    var image: Box<UIImage?> { get }
}

protocol UserListTVCViewModelType {
    var inputs: UserListTVCViewModelInputs { get }
    var outputs: UserListTVCViewModelOutputs { get }
}

class UserListTVCViewModel: UserListTVCViewModelType, UserListTVCViewModelInputs, UserListTVCViewModelOutputs {
    
    func configure(user: UserObject) {
        outputs.title.value = (user.firstName ?? "") + " " + (user.lastName ?? "")
    }
    
    let title: Box<String?> = Box(nil)
    let image: Box<UIImage?> = Box(nil)
    
    var inputs: UserListTVCViewModelInputs { return self  }
    var outputs: UserListTVCViewModelOutputs { return self  }
}
