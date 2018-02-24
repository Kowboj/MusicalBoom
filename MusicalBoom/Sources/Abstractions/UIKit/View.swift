//
//  View.swift
//  MusicalBoom
//
//  Created by mac on 10.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import UIKit

class View: UIView {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.lightGray
        setupViewHierarchy()
        setupProperties()
        setupLayoutConstraints()
    }
    
    override static var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    func setupViewHierarchy() {}
    func setupProperties() {}
    func setupLayoutConstraints() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
