//
//  UserImageTVCViewModel.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation
import UIKit

protocol UserImageTVCViewModelInputs {
    
}

protocol UserImageTVCViewModelOutputs {
    var image: Box<UIImage?> { get }
}

protocol UserImageTVCViewModelType {
    var inputs: UserImageTVCViewModelInputs { get }
    var outputs: UserImageTVCViewModelOutputs { get }
}

class UserImageTVCViewModel: UserImageTVCViewModelInputs, UserImageTVCViewModelOutputs, UserImageTVCViewModelType {
    
    let image: Box<UIImage?> = Box(nil)
    
    var inputs: UserImageTVCViewModelInputs { return self }
    var outputs: UserImageTVCViewModelOutputs { return self }
}
