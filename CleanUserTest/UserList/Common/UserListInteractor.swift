//
//  UserListInteractor.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

struct UserListInteractor {
    private let presenter: UserListPresentable
    
    init(presenter: UserListPresentable) {
        self.presenter = presenter
    }
}

extension UserListInteractor: UserListBusinessLogic {
    func getUserList() {
        do {
            if let data = UserDefaults.standard.object(forKey: "Users") as? Data/*, let userObjects = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [UserObject] */{
                
                let jsonDecoder = JSONDecoder()
                let userObjects = try jsonDecoder.decode([UserObject].self, from: data)
                
                presenter.presentUserList(with: UserListModels.Response(users: userObjects))
                
            } else {
                if let url = Bundle.main.url(forResource: "Users", withExtension: "json") {
                    let jsonDecoder = JSONDecoder()
                    let data = try Data(contentsOf: url)
                    let userObjects = try jsonDecoder.decode([UserObject].self, from: data)
                    
                    presenter.presentUserList(with: UserListModels.Response(users: userObjects))
                } else {
                    presenter.presentUserList(with: UserListModels.DataError(error: ApiError.objectSerialization(reason: "No File")))
                }
            }
            
        } catch {
            presenter.presentUserList(with: UserListModels.DataError(error: ApiError.objectSerialization(reason: error.localizedDescription)))
        }
    }
}
