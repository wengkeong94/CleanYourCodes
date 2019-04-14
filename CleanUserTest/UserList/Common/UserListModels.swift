//
//  UserListModels.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

enum UserListModels {
    struct Request {
        
    }
    
    struct Response {
        let users: [UserObject]
    }
    
    struct ViewModel {
        let viewModel: UserListVCViewModelType
    }
    
    struct DataError {
        let error: Error
    }
}

struct UserObject: Codable {
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
}

enum ApiError: Error {
    case objectSerialization(reason: String)
}
