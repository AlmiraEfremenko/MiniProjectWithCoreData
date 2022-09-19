//
//  CoreDataManager.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 15.09.2022.
//

import Foundation
import CoreData
import UIKit

// Хранилище которое отвечает за запись и чтение с CoreData

protocol ServiceCoreData {
    func addUsers(name: String)
    func getUser(_ index: Int) -> ModelUsers?
    func getUsers()
    func getUsersCount() -> Int
    func delete(_ index: Int)
    func update()
}

class CoreDataManager: ServiceCoreData {
    
    static let shared = CoreDataManager()
    
    private var users: [ModelUsers]?
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MiniProjectWithCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // добрались по contexta
    private lazy var context = persistentContainer.viewContext
    
    // функция по добавлению пользователей
    func addUsers(name: String) {
        
        do {
            let user = ModelUsers(context: context)
            user.name = name
            try context.save()
            getUsers()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // функция по получению элемента по индексу. возвращает пользователя(если он есть)
    func getUser(_ index: Int) -> ModelUsers? {
        users?[index]
    }
    
    // функция по получению пользователей
    func getUsers() {
        let fetchRequest: NSFetchRequest<ModelUsers> = ModelUsers.fetchRequest()
        do {
            users = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
            users = []
        }
    }
    
    // функция по получению кол-ва пользователей
    func getUsersCount() -> Int {
        users?.count ?? 0
    }
    
    // функция по удалению пользователя по индексу
    func delete(_ index: Int) {
        guard let user = users?[index] else { return }
        context.delete(user)
        do {
            try context.save()
            getUsers()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // функция в случае изменения контекста
    func update() {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
