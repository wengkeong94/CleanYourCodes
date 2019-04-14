//
//  UserListVCDS.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation
import UIKit

class UserListVCDS: NSObject {
    fileprivate var _users = [UserObject]()
    let UserListCellIdentifier = String(describing: UserListTVC.self)
    
    enum Section: Int {
        case users
    }
    
    func registerClasses(tableView: UITableView) {
        let userListTVCellNib = UINib(nibName: UserListCellIdentifier, bundle: nil)
        tableView.register(userListTVCellNib, forCellReuseIdentifier: UserListCellIdentifier)
    }
    
    func set(users: [UserObject]) {
        _users.removeAll()
        _users.append(contentsOf: users)
    }
    
    fileprivate func userCell(tableView: UITableView, for indexPath: IndexPath) -> UserListTVC? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListCellIdentifier, for: indexPath) as? UserListTVC else {
            return nil
        }
        let user = _users[indexPath.row]
        
        cell.configureWith(value: user)
        
        return cell
    }
}

extension UserListVCDS: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section(rawValue: section)
        
        switch section {
        case .some(.users):
            return _users.count
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)
        
        switch section {
        case .some(.users):
            if let cell = userCell(tableView: tableView, for: indexPath) {
                return cell
            }
        case .none:
            break
        }
        
        return UITableViewCell()
    }
}
