//
//  Presenter.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 14.09.2022.
//

import Foundation

// Presenter - сущность которая является связующим звеном между вью и моделью. Он принимает от вью действия пользователя и запрашивает данные у модели. Забирает данные и отправляет вью. От вью к презентеру будет протокол Output (что означает выходит из вью) и от презентера к вью(Input - что означает вход во вью)

class Presenter: PresenterInput {
    
    weak var view: PresenterOutput?
    private var serviceCoreData: ServiceCoreData
    
    init(view: PresenterOutput, serviceCoreData: ServiceCoreData) {
        self.view = view
        self.serviceCoreData = serviceCoreData
    }
    
    // описание самой функции по добавлению пользователей в хранилище. Вызываем хранилище и добавляем туда пользователя
    func addUser(nameUser: String) {
        serviceCoreData.addUsers(name: nameUser)
        view?.showDataUser()
    }
    
    // функция по получению пользователей
    func getDataUsers() {
        serviceCoreData.getUsers()
        view?.showDataUser()
    }
    
    // функция по получению кол-ва пользователей
    func getUsersCount() -> Int {
        serviceCoreData.getUsersCount()
    }
    
    // функция по получению  пользователя по индексу
    func getUser(_ index: Int) -> ModelUsers? {
        serviceCoreData.getUser(index)
    }
    
    // функция по удалению
    func deleteUser(_ index: Int) {
        serviceCoreData.delete(index)
        view?.showDataUser()
    }
    
    // функция по обновлению
    func updateUser() {
        serviceCoreData.update()
    }
}
