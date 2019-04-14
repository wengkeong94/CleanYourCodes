//
//  UserDetailsVC.swift
//  TestTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import UIKit

class UserDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: UserDetailsVCViewModelType = UserDetailsVCViewModel()
    let dataSource = UserDetailsVCDS()
    
    private lazy var interactor: UserDetailsBusinessLogic = UserDetailsInteractor.init(presenter: UserDetailsPresenter.init(viewController: self)) //Supposed to add worker
    private lazy var router: UserDetailsRoutable = UserDetailsRouter.init(viewController: self)

    // MARK: - Cache
    fileprivate var cellHeightCache = [IndexPath: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupListener()
        setupNavBar()
        // Do any additional setup after loading the view.
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
        
        viewModel.outputs.userImage.bind { [weak self] value in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.dataSource.set(image: value)
                strongSelf.tableView.reloadData()
            }
        }
        
        viewModel.outputs.informations.bind { [weak self] value in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.dataSource.set(informations: value)
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    fileprivate func setupNavBar() {
        self.navigationController?.navigationBar.topItem?.title = "Contacts"
        
        let cancelBtn = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelBtnDidClick)
        )
        
        let saveBtn = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(saveBtnDidClick)
        )
        
        self.navigationItem.leftBarButtonItem = cancelBtn
        self.navigationItem.rightBarButtonItem = saveBtn
    }
    
    @objc func cancelBtnDidClick() {
        router.backToUserList()
    }
    
    @objc func saveBtnDidClick() {
        guard let userObject = viewModel.outputs.userObject.value else { return }
        interactor.updateUserDetails(with: UserDetailsModels.Request(user: userObject))
    }
}

extension UserDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cellHeightCache[indexPath] {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let cell = cell as? InformationTVC {
            cell.delegate = self
        }
        
        cellHeightCache[indexPath] = cell.frame.height
    }
}

extension UserDetailsVC: InformationTVCDelegate {
    func informationTVC(_ cell: InformationTVC, textDidChange inputField: TextInputTVC) {
        guard let selectedInformation = viewModel.outputs.informations.value.filter ({
            (information: InformationTVCViewModelType) -> Bool in
            return information.outputs.inputFields.value.filter({
                (inputFields) -> Bool in
                return (inputFields.outputs.id.value == inputField.viewModel.outputs.id.value)
            }).count > 0
        }).first
            else { return }
        
        selectedInformation.outputs.inputFields.value = cell.viewModel.outputs.inputFields.value
        
        for input in selectedInformation.outputs.inputFields.value {
            switch input.outputs.id.value {
            case "firstName":
                viewModel.outputs.userObject.value?.firstName = input.outputs.text.value
                break
            case "lastName":
                viewModel.outputs.userObject.value?.lastName = input.outputs.text.value
                break
            case "email":
                viewModel.outputs.userObject.value?.email = input.outputs.text.value
                break
            case "phone":
                viewModel.outputs.userObject.value?.phone = input.outputs.text.value
                break
            default:
                break
            }
        }
    }
}

extension UserDetailsVC: UserDetailsDisplayable {
    func displayUserUpdated(with viewModel: UserDetailsModels.ViewModel) {
        let alert = UIAlertController(title: "Updated", message: "User is updated.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayUserUpdated(with error: UserDetailsModels.DataError) {
        //TODO: Show alert to notify user that saving was failed
    }
}
