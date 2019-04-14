//
//  UserDetailsPresenter.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

struct UserDetailsPresenter {
    private weak var viewController: UserDetailsDisplayable?
    
    init(viewController: UserDetailsDisplayable) {
        self.viewController = viewController
    }
}

extension UserDetailsPresenter: UserDetailsPresentable {
    func presentUserUpdated(with response: UserDetailsModels.Response) {
        let viewModel = UserDetailsVCViewModel()
        viewModel.inputs.configure(user: response.user)
        
        viewController?.displayUserUpdated(with: UserDetailsModels.ViewModel(viewModel: viewModel))
    }
    
    func presentUserUpdated(with error: UserDetailsModels.DataError) {
        viewController?.displayUserUpdated(with: error)
    }
}
