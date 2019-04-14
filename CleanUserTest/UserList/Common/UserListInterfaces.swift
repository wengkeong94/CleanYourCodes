//
//  UserListInterfaces.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

protocol UserListDisplayable: class { //View Controller
    func displayUserList(with viewModel: UserListModels.ViewModel)
    func displayUserList(with error: UserListModels.DataError)
}

protocol UserListBusinessLogic { //Interactor
    func getUserList()
}

protocol UserListPresentable { //Presenter
    func presentUserList(with response: UserListModels.Response)
    func presentUserList(with error: UserListModels.DataError)
}

protocol UserListRoutable { //Routable

}
