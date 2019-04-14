//
//  UserDetailsVCViewModel.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import Foundation

protocol UserDetailsVCViewModelInputs {
    func configure(user: UserObject)
}

protocol UserDetailsVCViewModelOutputs {
    var userImage: Box<UserImageTVCViewModelType> { get }
    var informations: Box<[InformationTVCViewModelType]> { get }
    
    var userObject: Box<UserObject?> { get }
}

protocol UserDetailsVCViewModelType {
    var inputs: UserDetailsVCViewModelInputs { get }
    var outputs: UserDetailsVCViewModelOutputs { get }
}

class UserDetailsVCViewModel: UserDetailsVCViewModelInputs, UserDetailsVCViewModelOutputs, UserDetailsVCViewModelType {
    
    func configure(user: UserObject) {
        var tempInformations = [InformationTVCViewModel]()
        
        let mainInformation = InformationTVCViewModel()
        mainInformation.outputs.sectionName.value = "Main Information"
        var mainInputs = [TextInputTVCViewModel]()
        
        if let firstName = user.firstName {
            let firstNameInput = TextInputTVCViewModel()
            firstNameInput.outputs.id.value = "firstName"
            firstNameInput.outputs.title.value = "First Name"
            firstNameInput.outputs.text.value = firstName
            mainInputs.append(firstNameInput)
        }
        
        if let lastName = user.lastName {
            let lastNameInput = TextInputTVCViewModel()
            lastNameInput.outputs.id.value = "lastName"
            lastNameInput.outputs.title.value = "Last Name"
            lastNameInput.outputs.text.value = lastName
            mainInputs.append(lastNameInput)
        }
        
        mainInformation.outputs.inputFields.value = mainInputs
        tempInformations.append(mainInformation)

        let subInformation = InformationTVCViewModel()
        subInformation.outputs.sectionName.value = "Sub Information"
        var subInputs = [TextInputTVCViewModel]()
        
        if let email = user.email {
            let emailInput = TextInputTVCViewModel()
            emailInput.outputs.id.value = "email"
            emailInput.outputs.title.value = "Email"
            emailInput.outputs.text.value = email
            subInputs.append(emailInput)
        }
        
        if let phone = user.phone {
            let phoneInput = TextInputTVCViewModel()
            phoneInput.outputs.id.value = "phone"
            phoneInput.outputs.title.value = "Phone"
            phoneInput.outputs.text.value = phone
            subInputs.append(phoneInput)
        }
        
        subInformation.outputs.inputFields.value = subInputs
        tempInformations.append(subInformation)
        
        outputs.informations.value = tempInformations
        outputs.userObject.value = user
    }
    
    let userImage: Box<UserImageTVCViewModelType> = Box(UserImageTVCViewModel())
    let informations: Box<[InformationTVCViewModelType]> = Box([])
    
    let userObject: Box<UserObject?> = Box(nil)
    
    var inputs: UserDetailsVCViewModelInputs { return self }
    var outputs: UserDetailsVCViewModelOutputs { return self }
}
