//
//  PresenterInput.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 14.09.2022.
//

import Foundation

// Данный протокол описывает функции по которым осуществляться будет работа презентера как класса.
protocol PresenterInput: AnyObject {
    
    func addUser(nameUser: String)
    func getDataUsers()
    func getUsersCount() -> Int
    func getUser(_ index: Int) -> ModelUsers?
    func deleteUser(_ index: Int)
    func updateUser()
}
