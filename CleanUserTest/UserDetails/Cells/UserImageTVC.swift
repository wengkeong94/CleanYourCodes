//
//  UserImageTVC.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import UIKit

class UserImageTVC: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    let viewModel: UserImageTVCViewModelType = UserImageTVCViewModel()

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
        viewModel.outputs.image.bind { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.imgView.image = $0
        }
    }
}

extension UserImageTVC {
    func configureWith(value: UserImageTVCViewModelType) {
        viewModel.outputs.image.value = value.outputs.image.value
    }
}
