//
//  ImageModifier.swift
//  DeezerPlayground
//
//  Created by Laurent Catalina on 24/06/2019.
//  Copyright © 2019 Laurent Catalina. All rights reserved.
//

import SwiftUI

struct ImageModifierRound:  ViewModifier {
    
    let size: (width: CGFloat, height: CGFloat)
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
            .font(.largeTitle)
    }
}
