//
//  UserDetailsInterfaces.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

protocol UserDetailsDisplayable: class { //View Controller
    func displayUserUpdated(with viewModel: UserDetailsModels.ViewModel)
    func displayUserUpdated(with error: UserDetailsModels.DataError)
}

protocol UserDetailsBusinessLogic { //Interactor
    func updateUserDetails(with request: UserDetailsModels.Request)
}

protocol UserDetailsPresentable { //Presenter
    func presentUserUpdated(with response: UserDetailsModels.Response)
    func presentUserUpdated(with error: UserDetailsModels.DataError)
}

protocol UserDetailsRoutable { //Routable
    func backToUserList()
}
