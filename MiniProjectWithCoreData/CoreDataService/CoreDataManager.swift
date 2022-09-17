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
    var users: [ModelUsers]? { get }
    func addUsers(name: String)
    func getUsers() -> [ModelUsers]?
    func delete(user: ModelUsers)
    func upDate(user: ModelUsers, name: String?, date: String?, gender: String?)
}

class CoreDataManager: ServiceCoreData {
    
    static let shared = CoreDataManager()
    
    var users: [ModelUsers]? {
        return getUsers()
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MiniProjectWithCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private lazy var context = persistentContainer.viewContext
    
    
    func addUsers(name: String) {
        
        if context.hasChanges {
            do {
                let user = ModelUsers(context: context)
                user.name = name
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func getUsers() -> [ModelUsers]? {
        let fetchRequest: NSFetchRequest<ModelUsers> = ModelUsers.fetchRequest()
        do {
            let users = try context.fetch(fetchRequest)
            return users
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func delete(user: ModelUsers) {
        context.delete(user)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func upDate(user: ModelUsers, name: String?, date: String?, gender: String?) {
        guard let name = name else { return }
        guard let date = date else { return }
        guard let gender = gender else { return }
        user.name = name
        user.date = date
        user.gender = gender
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
