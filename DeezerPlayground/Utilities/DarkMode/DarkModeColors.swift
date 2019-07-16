//
//  DarkModeColors.swift
//  DeezerPlayground
//
//  Created by Laurent Catalina on 01/07/2019.
//  Copyright © 2019 Laurent Catalina. All rights reserved.
//

import UIKit

func dynamicColor(_ lightColor: UIColor, _ darkColor: UIColor) -> UIColor {
    return UIColor { traitCollection -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return darkColor
        } else {
            return lightColor
        }
    }
}

/// Main title - dynamic color
let maintTitle = dynamicColor(.black, .white)
