//
//  DetailViewController.swift
//  MiniProjectWithCoreData
//
//  Created by MAC on 15.09.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        let button = UIBarButtonItem(customView: detailView.barButton)
        navigationItem.rightBarButtonItem = button
    }
}
