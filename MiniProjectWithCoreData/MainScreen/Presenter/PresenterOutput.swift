//
//  PresenterInput.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 14.09.2022.
//

import Foundation

// передача данных из хранилища в контроллер
protocol PresenterOutput: AnyObject {
    
    func showDataUser()
}
