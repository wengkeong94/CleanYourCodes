//
//  UserDetailsModels.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

enum UserDetailsModels {
    struct Request {
        let user: UserObject
    }
    
    struct Response {
        let user: UserObject
    }
    
    struct ViewModel {
        let viewModel: UserDetailsVCViewModelType
    }
    
    struct DataError {
        let error: Error
    }
}
