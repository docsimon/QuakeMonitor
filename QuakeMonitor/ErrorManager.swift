//
//  ErrorManager.swift
//  QuakeMonitor
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation
import UIKit

struct ErrorData{
    let errorTitle: String
    let errorMsg: String
}

struct ErrorManager {
    
   static func displayError<T>(errorTitle: String, errorMsg: String?, presenting: T? ){
        let alert = UIAlertController(title: errorTitle, message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        DispatchQueue.main.async {
            (presenting as? UIViewController)?.present(alert, animated: true)
        }
    }
    
}
