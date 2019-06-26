//
//  UIViewController+extension.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 01/05/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import UIKit

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        vSpinner = spinnerView
    }

    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
