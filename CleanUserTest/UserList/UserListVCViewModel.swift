//
//  UserListVCViewModel.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

protocol UserListVCViewModelInputs {
    func refreshUserList()
}

protocol UserListVCViewModelOutputs {
    var users: Box<[UserObject]> { get }
    
    var notifyDelegateRefreshUserList: Box<Void?> { get }
}

protocol UserListVCViewModelType {
    var inputs: UserListVCViewModelInputs { get }
    var outputs: UserListVCViewModelOutputs { get }
}

class UserListVCViewModel: UserListVCViewModelInputs, UserListVCViewModelOutputs, UserListVCViewModelType {
    func refreshUserList() {
        outputs.notifyDelegateRefreshUserList.value = ()
    }
    
    let users: Box<[UserObject]> = Box([])
    
    let notifyDelegateRefreshUserList: Box<Void?> = Box(nil)
    
    var inputs: UserListVCViewModelInputs { return self }
    var outputs: UserListVCViewModelOutputs { return self }
}
