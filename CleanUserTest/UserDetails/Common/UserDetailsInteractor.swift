//
//  UserDetailsInteractor.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

struct UserDetailsInteractor {
    private let presenter: UserDetailsPresentable
    
    init(presenter: UserDetailsPresentable) {
        self.presenter = presenter
    }
    
    private func updateUserDetailsData(userObjects: [UserObject], selectedUser: UserObject) {
        do {
            var userObjectsArr = userObjects
            
            var index: Int = 0
            
            for i: Int in 0..<userObjects.count {
                if userObjects[i].id == selectedUser.id {
                    index = i
                }
            }
            
            userObjectsArr[index] = selectedUser

            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(userObjectsArr)

            let userDefaults = UserDefaults.standard
            userDefaults.set(jsonData, forKey: "Users")
            
            presenter.presentUserUpdated(with: UserDetailsModels.Response(user: selectedUser))
        } catch {
             presenter.presentUserUpdated(with: UserDetailsModels.DataError(error: ApiError.objectSerialization(reason: error.localizedDescription)))
        }
    }
}

extension UserDetailsInteractor: UserDetailsBusinessLogic {
    func updateUserDetails(with request: UserDetailsModels.Request) {
        do {
            if let data = UserDefaults.standard.object(forKey: "Users") as? Data {
                
                let jsonDecoder = JSONDecoder()
                let userObjects = try jsonDecoder.decode([UserObject].self, from: data)
                
                updateUserDetailsData(userObjects: userObjects, selectedUser: request.user)
                
            } else {
                if let url = Bundle.main.url(forResource: "Users", withExtension: "json") {
                    let jsonDecoder = JSONDecoder()
                    let data = try Data(contentsOf: url)
                    let userObjects = try jsonDecoder.decode([UserObject].self, from: data)
                    
                    updateUserDetailsData(userObjects: userObjects, selectedUser: request.user)

                } else {
                    presenter.presentUserUpdated(with: UserDetailsModels.DataError(error: ApiError.objectSerialization(reason: "No File")))
                }
            }
        } catch {
            presenter.presentUserUpdated(with: UserDetailsModels.DataError(error: ApiError.objectSerialization(reason: error.localizedDescription)))
        }
    }
}
