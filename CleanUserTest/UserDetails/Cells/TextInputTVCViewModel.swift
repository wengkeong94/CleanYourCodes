//
//  TextInputTVCViewModel.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation
import UIKit

protocol TextInputTVCViewModelInputs {
    
}

protocol TextInputTVCViewModelOutputs {
    var text: Box<String?> { get }
    var id: Box<String?> { get }
    var title: Box<String?> { get }
}

protocol TextInputTVCViewModelType {
    var inputs: TextInputTVCViewModelInputs { get }
    var outputs: TextInputTVCViewModelOutputs { get }
}

class TextInputTVCViewModel: TextInputTVCViewModelInputs, TextInputTVCViewModelOutputs, TextInputTVCViewModelType {
    
    let text: Box<String?> = Box(nil)
    let id: Box<String?> = Box(nil)
    let title: Box<String?> = Box(nil)
    
    var inputs: TextInputTVCViewModelInputs { return self }
    var outputs: TextInputTVCViewModelOutputs { return self }
}

protocol TextInputTVCDelegate: class {
    func textDidChange(
        _ cell: TextInputTVC,
        textField: UITextField
    )
}
