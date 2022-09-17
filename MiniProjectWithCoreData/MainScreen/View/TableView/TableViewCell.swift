//
//  TableViewCell.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 14.09.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifire = "TableViewCell"
    
     lazy var nameUser: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var users: ModelUsers? {
        didSet {
            nameUser.text = users?.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(nameUser)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameUser.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

