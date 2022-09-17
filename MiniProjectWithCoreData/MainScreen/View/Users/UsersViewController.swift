//
//  ViewController.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 14.09.2022.
//

import UIKit
import CoreData

protocol UsersViewControllerDelegate: AnyObject {
    func addUsers(nameUser: String)
}

class UsersViewController: UIViewController, UsersViewControllerDelegate, PresenterInput {
    
    weak var output: PresenterOutput?
    var usersView = UsersView()
    var model = CoreDataManager.shared
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifire)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showDataUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        view = usersView
        usersView.delegate = self
        setupHierarchy()
        setupLayout()
        output?.getDataUsers()
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // здесь получить данные и отобразить их во вью
    
    func showDataUser() {
        self.tableView.reloadData()
    }
    
    // здесь контроллер сохранит данные юзера
    func addUsers(nameUser: String) {
        output?.saveDataUsers(nameUser: nameUser)
        print(nameUser)
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifire, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.users = model.users?[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.detailView.userInfo = model.users?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
//    func tableView(_ tableView: UITableView,
//                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    {
//
//        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
//            guard let user = self.model.users?[indexPath.row] else { return }
//            self.output?.deleteUser(user: user)
//
//        }
//        return UISwipeActionsConfiguration(actions: [action])
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        tableView.deleteRows(at: [indexPath], with: .fade)
//
//        if editingStyle == .delete {
//            guard let user = model.users?[indexPath.row] else { return }
//            output?.deleteUser(user: user)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            self.tableView.reloadData()
//
//        } else if editingStyle == .insert {
//
//        }
//    }
}
