//
//  UIViewController+Extension.swift
//  TestRX
//
//  Created by Mahmoud Alkady on 13/09/2022.
//

import UIKit
extension UIViewController {
    func showAlertMesage(_ message: String){
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
