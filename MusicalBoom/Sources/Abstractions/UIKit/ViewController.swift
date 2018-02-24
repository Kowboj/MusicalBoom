//
//  ViewController.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("Implementation unavailable")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupProperties()
    }

    func setupNavigationItem() {}
    func setupProperties() {}
    
}

