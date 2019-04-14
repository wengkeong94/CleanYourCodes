//
//  TextInputTVC.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import UIKit

class TextInputTVC: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let viewModel: TextInputTVCViewModelType = TextInputTVCViewModel()
    weak var delegate: TextInputTVCDelegate?

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
        textField.addTarget(self,
                            action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)
        
        viewModel.outputs.title.bind { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.titleLbl.text = $0
        }
        
        viewModel.outputs.text.bind { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.textField.text = $0
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.outputs.text.value = textField.text

        delegate?.textDidChange(self, textField: textField)
    }
}

extension TextInputTVC {
    func configureWith(value: TextInputTVCViewModelType) {
        viewModel.outputs.id.value = value.outputs.id.value
        viewModel.outputs.title.value = value.outputs.title.value
        viewModel.outputs.text.value = value.outputs.text.value
    }
}
