//
//  Helpers.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 10/04/2023.
//

import Foundation
import UIKit

struct NavigationBarConfigurer {
    
    static func customNavBarAppearance() -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()
        
        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = UIColor(named: K.colors.barAppearanceColor)
        
        // Apply white colored normal and large titles.
        customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      
        return customNavBarAppearance
    }
    
    static func customNavBarAppearanceBlur() -> UINavigationBarAppearance {
        let blurAppearance = UINavigationBarAppearance()
        blurAppearance.configureWithTransparentBackground()
        blurAppearance.backgroundColor = UIColor(named: K.colors.barAppearanceColor)?.withAlphaComponent(0.95)
        blurAppearance.backgroundEffect = UIBlurEffect(style: .extraLight)
        
        // Apply white colored normal and large titles.
        blurAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        return blurAppearance
    }
    
    static func customNavigationBar() {
        UINavigationBar.appearance().prefersLargeTitles = true
    }
    
    static func customRightBarButtonItem() {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 28)]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().tintColor = UIColor.white
    }
}

struct K {
    
    static let categoryCellId = "CategoryCellId"
    static let toDodCellId = "ToDoItemCell"
    static let arrayKey = "ToDoListArray"
    
    struct colors {
        static let mainBackgroundColor = "MainBackcroundColor"
        static let barAppearanceColor = "BarAppearanceColor"
        static let searchFieldColor = "SearchFieldColor"
        static let cellColors = "BEDEFE"
    }
}
