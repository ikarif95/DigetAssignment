//
//  ViewControllerExtension.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//


import UIKit

extension UIViewController {
        
    func alert(title: String? = nil, message: String? = nil, btn1Text: String, btn1Handler: @escaping (() -> (Void)), btn2Text: String, btn2Stype: UIAlertAction.Style? = .default, btn2Handler: @escaping (() -> (Void))) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btn1Text, style: .default, handler: { (_) in btn1Handler() }))
        alert.addAction(UIAlertAction(title: btn2Text, style: btn2Stype ?? .default, handler: { (_) in btn2Handler() }))
        alert.view.tintColor = .primary
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
