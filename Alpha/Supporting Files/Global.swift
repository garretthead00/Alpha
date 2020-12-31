//
//  Global.swift
//  Alpha
//
//  Created by Garrett Head on 9/12/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Date
// Formats the date object (self) into a formatted string. Ex "MMM dd, yyyy"
extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}


// MARK: - Alerts and Actionsheets
// Custom action sheet with check list items. Single selection list with check mark indicator
extension UIAlertController {
    static func actionSheetWithItems<A : Equatable>(items : [(title : String, value : A)], currentSelection : A? = nil, action : @escaping (A) -> Void) -> UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for (var title, value) in items {
            if let selection = currentSelection, value == selection {
                // Note that checkmark and space have a neutral text flow direction so this is correct for RTL
                title = "✔︎ " + title
            }
            controller.addAction(
                UIAlertAction(title: title, style: .default) {_ in
                    action(value)
                }
            )
        }
        return controller
    }
}

extension UIColor {
    var name: String? {
        switch self {
        case UIColor.black: return "Black"
        case UIColor.systemGray: return "Gray"
        case UIColor.white: return "White"
        case UIColor.gray: return "Gray"
        case UIColor.systemRed: return "Red"
        case UIColor.systemGreen: return "Green"
        case UIColor.systemBlue: return "Blue"
        case UIColor.systemTeal: return "Light Blue"
        case UIColor.systemYellow: return "Yellow"
        case UIColor.systemOrange: return "Orange"
        case UIColor.systemIndigo: return "Indigo"
        case UIColor.systemPurple: return "Purple"
        case UIColor.systemPink: return "Pink"
        default: return nil
        }
    }
}

extension UserDefaults {
     func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
        }
        return color
     }

     func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
        }
        set(colorData, forKey: key)
     }

}

extension UIPageViewController {
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}


