//
//  InformationTVCViewModel.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

protocol InformationTVCViewModelInputs {
    
}

protocol InformationTVCViewModelOutputs {
    var sectionName: Box<String?> { get }
    var inputFields: Box<[TextInputTVCViewModelType]> { get }
}

protocol InformationTVCViewModelType {
    var inputs: InformationTVCViewModelInputs { get }
    var outputs: InformationTVCViewModelOutputs { get }
}

class InformationTVCViewModel: InformationTVCViewModelInputs, InformationTVCViewModelOutputs, InformationTVCViewModelType {
    
    let sectionName: Box<String?> = Box(nil)
    let inputFields: Box<[TextInputTVCViewModelType]> = Box([])
    
    var inputs: InformationTVCViewModelInputs { return self }
    var outputs: InformationTVCViewModelOutputs { return self }
}

protocol InformationTVCDelegate: class {
    func informationTVC(
        _ cell: InformationTVC,
        textDidChange inputField: TextInputTVC
    )
}
