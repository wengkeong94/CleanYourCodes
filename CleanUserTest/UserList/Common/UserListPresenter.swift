//
//  UserListPresenter.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

struct UserListPresenter {
    private weak var viewController: UserListDisplayable?
    
    init(viewController: UserListDisplayable) {
        self.viewController = viewController
    }
}

extension UserListPresenter: UserListPresentable {
    func presentUserList(with response: UserListModels.Response) {
        let viewModel = UserListVCViewModel()
        viewModel.outputs.users.value = response.users
        
        viewController?.displayUserList(with: UserListModels.ViewModel(viewModel: viewModel))
    }
    
    func presentUserList(with error: UserListModels.DataError) {
        viewController?.displayUserList(with: error)
    }
}
