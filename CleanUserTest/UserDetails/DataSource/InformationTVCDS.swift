//
//  InformationTVCDS.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation
import UIKit

class InformationTVCDS: NSObject {
    fileprivate var _textInputs = [TextInputTVCViewModelType]()
    let TextInputCellIdentifier = String(describing: TextInputTVC.self)
    
    enum Section: Int {
        case inputs
    }
    
    func registerClasses(tableView: UITableView) {
        let textInputTVCellNib = UINib(nibName: TextInputCellIdentifier, bundle: nil)
        tableView.register(textInputTVCellNib, forCellReuseIdentifier: TextInputCellIdentifier)
    }
    
    func set(inputs: [TextInputTVCViewModelType]) {
        _textInputs.removeAll()
        _textInputs.append(contentsOf: inputs)
    }
    
    fileprivate func inputCell(tableView: UITableView, for indexPath: IndexPath) -> TextInputTVC? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextInputCellIdentifier, for: indexPath) as? TextInputTVC else {
            return nil
        }
        let input = _textInputs[indexPath.row]
        
        cell.configureWith(value: input)
        
        return cell
    }
}

extension InformationTVCDS: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section(rawValue: section)
        
        switch section {
        case .some(.inputs):
            return _textInputs.count
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)
        
        switch section {
        case .some(.inputs):
            if let cell = inputCell(tableView: tableView, for: indexPath) {
                return cell
            }
        case .none:
            break
        }
        
        return UITableViewCell()
    }
}
