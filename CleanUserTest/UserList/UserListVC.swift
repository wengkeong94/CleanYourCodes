//
//  UserListVC.swift
//  CleanUserTest
//
//  Created by Walter Wong on 14/04/2019.
//  Copyright © 2019 CleanYourCodes. All rights reserved.
//

import UIKit

class UserListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: UserListVCViewModelType = UserListVCViewModel()
    let dataSource = UserListVCDS()
    
    private lazy var interactor: UserListBusinessLogic = UserListInteractor.init(presenter: UserListPresenter.init(viewController: self)) //Supposed to add worker
    private lazy var router: UserListRoutable = UserListRouter.init(viewController: self)
    
    // MARK: - Cache
    fileprivate var cellHeightCache = [IndexPath: CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupListener()
        setupNavBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.refreshUserList()
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
        
        viewModel.outputs.users.bind { [weak self] value in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.dataSource.set(users: value)
                strongSelf.tableView.reloadData()
            }
        }
        
        viewModel.outputs.notifyDelegateRefreshUserList.bind { [weak self] in
            guard let strongSelf = self else { return }
            guard let _ = $0 else { return }
            
            strongSelf.interactor.getUserList()
            strongSelf.viewModel.outputs.notifyDelegateRefreshUserList.value = nil
        }
    }
    
    fileprivate func setupNavBar() {
        self.navigationController?.navigationBar.topItem?.title = "Contacts"
        
        let searchBtn = UIBarButtonItem(
            image: UIImage(named: "search")?
                .withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(searchBtnDidClick)
        )

        let plusBtn = UIBarButtonItem(
            image: UIImage(named: "plus")?
                .withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(plusBtnDidClick)
        )

        self.navigationItem.leftBarButtonItem = searchBtn
        self.navigationItem.rightBarButtonItem = plusBtn
        
    }
    
    @objc func searchBtnDidClick() {
        //TODO: go to search screen
    }
    
    @objc func plusBtnDidClick() {
        //TODO: go to plus screen
    }
}

extension UserListVC: UserListDisplayable {
    func displayUserList(with viewModel: UserListModels.ViewModel) {
        self.viewModel.outputs.users.value = viewModel.viewModel.outputs.users.value
    }
    
    func displayUserList(with error: UserListModels.DataError) {
        //TODO: Settle error view
    }
}

extension UserListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cellHeightCache[indexPath] {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightCache[indexPath] = cell.frame.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = viewModel.outputs.users.value[indexPath.row]
        router.goToUserDetail(with: selectedUser)
    }
}


