//
//  Presenter.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 14.09.2022.
//

import Foundation

//PresenterOutput  - выходит из презентера в модель
//PrsenterInput - вход в презентер из модели

class Presenter: PresenterOutput {
    
    weak var inputView: PresenterInput?
    private var serviceCoreData: ServiceCoreData
    
    init(inputView: PresenterInput, serviceCoreData: ServiceCoreData) {
        self.inputView = inputView
        self.serviceCoreData = serviceCoreData
    }
    
    func saveDataUsers(nameUser: String) {
        serviceCoreData.addUsers(name: nameUser)
        inputView?.showDataUser()
    }
    
    func getDataUsers() {
        inputView?.showDataUser()
    }
    
    func deleteUser(user: ModelUsers) {
        serviceCoreData.delete(user: user)
        inputView?.showDataUser()
    }
    
    func updateUser(user: ModelUsers) {
        
    }
}
