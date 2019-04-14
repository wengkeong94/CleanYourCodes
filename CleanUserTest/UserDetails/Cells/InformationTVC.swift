//
//  InformationTVC.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import UIKit

class InformationTVC: UITableViewCell {
    
    @IBOutlet weak var sectionNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var csHeightTableView: NSLayoutConstraint!
    
    let viewModel: InformationTVCViewModelType = InformationTVCViewModel()
    let dataSource = InformationTVCDS()
    
    // MARK: - Cache
    fileprivate var cellHeightCache = [IndexPath: CGFloat]()
    
    weak var delegate: InformationTVCDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupListener()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func setupView() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    fileprivate func setupListener() {
        dataSource.registerClasses(tableView: tableView)
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        viewModel.outputs.sectionName.bind { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.sectionNameLbl.text = $0
        }
        
        viewModel.outputs.inputFields.bind { [weak self] value in
            guard let strongSelf = self else { return }
            
            strongSelf.dataSource.set(inputs: value)
            strongSelf.tableView.reloadData()
            strongSelf.tableView.layoutIfNeeded()
            strongSelf.csHeightTableView.constant = strongSelf.tableView.contentSize.height
        }
    }
}

extension InformationTVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cellHeightCache[indexPath] {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TextInputTVC {
            cell.delegate = self
        }
        
        cellHeightCache[indexPath] = cell.frame.height
    }
}

extension InformationTVC: TextInputTVCDelegate {
    func textDidChange(_ cell: TextInputTVC, textField: UITextField) {
        guard var inputField = viewModel.outputs.inputFields.value.filter({$0.outputs.id.value == cell.viewModel.outputs.id.value}).first else { return }
        inputField.outputs.text.value = cell.viewModel.outputs.text.value
        delegate?.informationTVC(self, textDidChange: cell)
    }
}

extension InformationTVC {
    func configureWith(value: InformationTVCViewModelType) {
        viewModel.outputs.sectionName.value = value.outputs.sectionName.value
        viewModel.outputs.inputFields.value = value.outputs.inputFields.value
    }
}
