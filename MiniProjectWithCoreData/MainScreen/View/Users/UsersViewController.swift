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

// Данный класс является Делегатом и выполняет функцию по добавлению пользователей
class UsersViewController: UIViewController, UsersViewControllerDelegate, PresenterOutput {
    
    var presenter: PresenterInput?
    var usersView = UsersView()
    
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
        presenter?.getDataUsers()
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
    
    // функция по добавлению пользователя через презентер. Тоесть вьюконтроллер вызывает презентер и его функцию addUser(nameUser: nameUser)
    func addUsers(nameUser: String) {
        presenter?.addUser(nameUser: nameUser)
        print(nameUser)
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getUsersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifire, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        cell.users = presenter?.getUser(indexPath.row)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.detailView.userInfo = presenter?.getUser(indexPath.row)
        vc.detailView.delegate = presenter
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            presenter?.deleteUser(indexPath.row)
        }
    }
}
