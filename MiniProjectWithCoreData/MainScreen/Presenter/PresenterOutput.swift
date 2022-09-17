//
//  PresenterOutput.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 14.09.2022.
//

import Foundation

// правила по передачи данных в хранилище
protocol PresenterOutput: AnyObject {
    
    func saveDataUsers(nameUser: String)
    func getDataUsers()
    func deleteUser(user: ModelUsers)
    func updateUser(user: ModelUsers)
}
