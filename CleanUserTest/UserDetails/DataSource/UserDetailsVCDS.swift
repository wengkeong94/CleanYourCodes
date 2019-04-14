//
//  UserDetailsVCDS.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation
import UIKit

class UserDetailsVCDS: NSObject {
    fileprivate var _image: UserImageTVCViewModelType = UserImageTVCViewModel()
    fileprivate var _informations = [InformationTVCViewModelType]()
    
    let ImageCellIdentifier = String(describing: UserImageTVC.self)
    let InformationCellIdentifier = String(describing: InformationTVC.self)
    
    enum Section: Int, CaseIterable {
        case image
        case informations
    }
    
    func registerClasses(tableView: UITableView) {
        let imageTVCellNib = UINib(nibName: ImageCellIdentifier, bundle: nil)
        let informationTVCellNib = UINib(nibName: InformationCellIdentifier, bundle: nil)
        tableView.register(imageTVCellNib, forCellReuseIdentifier: ImageCellIdentifier)
        tableView.register(informationTVCellNib, forCellReuseIdentifier: InformationCellIdentifier)
    }
    
    func set(image: UserImageTVCViewModelType) {
        _image = image
    }
    
    func set(informations: [InformationTVCViewModelType]) {
        _informations.removeAll()
        _informations.append(contentsOf: informations)
    }
    
    fileprivate func imageCell(tableView: UITableView, for indexPath: IndexPath) -> UserImageTVC? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCellIdentifier, for: indexPath) as? UserImageTVC else {
            return nil
        }

        cell.configureWith(value: _image)
        
        return cell
    }
    
    fileprivate func informationCell(tableView: UITableView, for indexPath: IndexPath) -> InformationTVC? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationCellIdentifier, for: indexPath) as? InformationTVC else {
            return nil
        }
        let information = _informations[indexPath.row]
        
        cell.configureWith(value: information)
        
        return cell
    }
}

extension UserDetailsVCDS: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section(rawValue: section)
        
        switch section {
        case .some(.image):
            return 1
        case .some(.informations):
            return _informations.count
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)
        
        switch section {
        case .some(.image):
            if let cell = imageCell(tableView: tableView, for: indexPath) {
                return cell
            }
        case .some(.informations):
            if let cell = informationCell(tableView: tableView, for: indexPath) {
                return cell
            }
        case .none:
            break
        }
        
        return UITableViewCell()
    }
}
