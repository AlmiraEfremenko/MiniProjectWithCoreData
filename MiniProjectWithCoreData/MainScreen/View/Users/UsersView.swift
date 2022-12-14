//
//  UsersView.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 14.09.2022.
//

import UIKit

// Данный класс является Делегатором. Он передает свои функции по добавлению пользователей посредством нажатия кнопки UsersViewControllerу. Это как раз использование делегата как паттерна общения между вью и вьюконтроллером. В свою очередь в данном классе есть свойтсво  weak var delegate: UsersViewControllerDelegate? и далее мы вызываем наш делегат и вызываем его функцию.

class UsersView: UIView {
    
    lazy var textField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    weak var delegate: UsersViewControllerDelegate?
    
    private lazy var button: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Press", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // вызываем функцию addUsers(nameUser: name)  и  передаем туда наше имя которое ввел в текстфилд пользователь
    @objc func tapButton() {
        guard let name = textField.text else { return }
        delegate?.addUsers(nameUser: name)
        textField.text = ""
    }
    
    private func setupHierarchy() {
        addSubview(textField)
        addSubview(button)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 340),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
