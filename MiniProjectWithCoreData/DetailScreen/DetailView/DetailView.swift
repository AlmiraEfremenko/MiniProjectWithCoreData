//
//  DetailView.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 15.09.2022.
//

import Foundation
import UIKit

enum Gender {
    case male
    case female
}

class DetailView: UIView {
    
    weak var delegate: PresenterInput?
    var genderChoice = ["male", "female"] 
    
    private lazy var avatar: UIImageView = {
        var avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 150 / 2
        avatar.clipsToBounds = true
        avatar.image = UIImage(named: "avatar")
        return avatar
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var stackViewPerson: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var personImage: UIImageView = {
        var personImage = UIImageView()
        personImage.image = UIImage(systemName: "person.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        personImage.layer.cornerRadius = 10
        personImage.clipsToBounds = true
        personImage.translatesAutoresizingMaskIntoConstraints = false
        return personImage
    }()
    
    private lazy var namePerson: UITextField = {
        var namePerson = UITextField()
        namePerson.isEnabled = false
        namePerson.placeholder = "Name"
        namePerson.translatesAutoresizingMaskIntoConstraints = false
        return namePerson
    }()
    
    private lazy var stackViewCalendar: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var calendarImage: UIImageView = {
        var calendarImage = UIImageView()
        calendarImage.image = UIImage(systemName: "calendar")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        calendarImage.layer.cornerRadius = 10
        calendarImage.clipsToBounds = true
        calendarImage.translatesAutoresizingMaskIntoConstraints = false
        return calendarImage
    }()
    
    private lazy var calendarData: UITextField = {
        var calendarData = UITextField()
        calendarData.isEnabled = false
        calendarData.placeholder = "Date of Birth"
        calendarData.delegate = self
        calendarData.translatesAutoresizingMaskIntoConstraints = false
        return calendarData
    }()
    
    private lazy var stackViewGender: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var genderImage: UIImageView = {
        var genderImage = UIImageView()
        genderImage.image = UIImage(systemName: "person.2.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        genderImage.layer.cornerRadius = 10
        genderImage.clipsToBounds = true
        genderImage.translatesAutoresizingMaskIntoConstraints = false
        return genderImage
    }()
    
    private lazy var gender: UITextField = {
        var gender = UITextField()
        gender.isEnabled = false
        gender.placeholder = "Gender"
        gender.translatesAutoresizingMaskIntoConstraints = false
        return gender
    }()
    
    lazy var barButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isChangeUserFields = false
    
    @objc func addTapped() {
                
        if isChangeUserFields {
            namePerson.isEnabled = false
            calendarData.isEnabled = false
            gender.isEnabled = false
            barButton.setTitle("Edit", for: .normal)
            userInfo?.name = namePerson.text
            userInfo?.date = calendarData.text
            userInfo?.gender = gender.text
            delegate?.updateUser()
        } else {
            namePerson.isEnabled = true
            calendarData.isEnabled = true
            gender.isEnabled = true
            barButton.setTitle("Save", for: .normal)
        }
        isChangeUserFields.toggle()
    }
    
    var userInfo: ModelUsers? {
        didSet {
            namePerson.text = userInfo?.name
            calendarData.text = userInfo?.date
            gender.text = userInfo?.gender
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHirarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHirarchy() {
        addSubview(avatar)
        addSubview(stackView)
        stackView.addArrangedSubview(stackViewPerson)
        stackView.addArrangedSubview(stackViewCalendar)
        stackView.addArrangedSubview(stackViewGender)
        stackViewPerson.addArrangedSubview(personImage)
        stackViewPerson.addArrangedSubview(namePerson)
        stackViewCalendar.addArrangedSubview(calendarImage)
        stackViewCalendar.addArrangedSubview(calendarData)
        stackViewGender.addArrangedSubview(genderImage)
        stackViewGender.addArrangedSubview(gender)
        addSubview(barButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            avatar.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 150),
            avatar.heightAnchor.constraint(equalToConstant: 150),
            
            stackView.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -300),
            personImage.widthAnchor.constraint(equalToConstant: 30),
            personImage.heightAnchor.constraint(equalToConstant: 30),
            
            calendarImage.widthAnchor.constraint(equalToConstant: 30),
            calendarImage.heightAnchor.constraint(equalToConstant: 30),
            
            genderImage.widthAnchor.constraint(equalToConstant: 30),
            genderImage.heightAnchor.constraint(equalToConstant: 30),
            
            barButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            barButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            barButton.widthAnchor.constraint(equalToConstant: 100),
            barButton.heightAnchor.constraint(equalToConstant: 35)
            
        ])
    }
}

extension DetailView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == calendarData {
            if (calendarData.text?.count == 2) || (calendarData.text?.count == 5) {
                if !(string == "") {
                    calendarData.text = (calendarData.text)! + "."
                }
            }
            guard let text = textField.text?.count else { return false }
            return !(text > 9 && (string.count ) > range.length)
        }
        else {
            return true
        }
    }
}
