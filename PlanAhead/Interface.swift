//
//  Interface.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 11/04/2023.
//

import Foundation
import UIKit

class Interface: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder _aDecoder: NSCoder) {
        super.init(coder: _aDecoder)
    }
    
    func setUpView() {
        backgroundColor = UIColor(named: K.colors.mainBackgroundColor)
    }
    
    func configNavigationBar(navItem: UINavigationItem, maintTitle: String, rBtnTitle: String, target: Any?, rBtnAction: Selector) {
        let addButton = UIBarButtonItem(title: rBtnTitle, style: .plain, target: target, action: rBtnAction)
        navItem.rightBarButtonItem = addButton
        navItem.title = maintTitle
    }
}
