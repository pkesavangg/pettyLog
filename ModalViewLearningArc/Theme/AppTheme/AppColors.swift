//
//  AppColors.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//

import SwiftUI

enum AppColors {
    enum Theme {
        case blue, red, yellow
        
        var palette: Palette {
            Palette.forTheme(self)
        }
    }
    
    struct Palette {
        let primary: Color
        let secondary: Color
        let background: Color
        let surface: Color
        let error: Color
        let onPrimary: Color
        let onSecondary: Color
        let onBackground: Color
        let onSurface: Color
        let onError: Color
        
        static func forTheme(_ theme: Theme) -> Palette {
            switch theme {
            case .blue:
                return Palette(
                    primary: Color("BluePrimary"),
                    secondary: Color("BlueSecondary"),
                    background: Color("BlueBackground"),
                    surface: Color("BlueSurface"),
                    error: Color("BlueError"),
                    onPrimary: Color("BlueOnPrimary"),
                    onSecondary: Color("BlueOnSecondary"),
                    onBackground: Color("BlueOnBackground"),
                    onSurface: Color("BlueOnSurface"),
                    onError: Color("BlueOnError")
                )
            case .red:
                return Palette(
                    primary: Color("RedPrimary"),
                    secondary: Color("RedSecondary"),
                    background: Color("RedBackground"),
                    surface: Color("RedSurface"),
                    error: Color("RedError"),
                    onPrimary: Color("RedOnPrimary"),
                    onSecondary: Color("RedOnSecondary"),
                    onBackground: Color("RedOnBackground"),
                    onSurface: Color("RedOnSurface"),
                    onError: Color("RedOnError")
                )
            case .yellow:
                return Palette(
                    primary: Color("YellowPrimary"),
                    secondary: Color("YellowSecondary"),
                    background: Color("YellowBackground"),
                    surface: Color("YellowSurface"),
                    error: Color("YellowError"),
                    onPrimary: .black,
                    onSecondary: .black,
                    onBackground: .black,
                    onSurface: .black,
                    onError: .white
                )
            }
        }
    }
}

