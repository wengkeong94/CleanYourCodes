//
//  UserListTVC.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import UIKit

class UserListTVC: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    let viewModel: UserListTVCViewModelType = UserListTVCViewModel()
    
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
        selectionStyle = .none
    }
    
    fileprivate func setupListener() {
        viewModel.outputs.title.bind { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.titleLbl.text = $0
        }
        
        viewModel.outputs.image.bind { [weak self] in
            guard let strongSelf = self else { return }
            guard let image = $0 else { return }
            
            strongSelf.imgView.image = image
        }
    }
}

extension UserListTVC {
    func configureWith(value: UserObject) {
        viewModel.inputs.configure(user: value)
    }
}
