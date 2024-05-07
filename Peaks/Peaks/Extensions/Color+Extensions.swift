//
//  Color+Extensions.swift
//  WalkStreets
//
//  Created by Lukasz on 04/04/2024.
//
// https://medium.com/ios-os-x-development/ios-extend-uicolor-with-custom-colors-93366ae148e6

import SwiftUI

extension Color {
    init(withHex: Int) {
        self.init(red: Double((withHex >> 16) & 0xff) / 255.0,
                  green: Double((withHex >> 8) & 0xff) / 255.0,
                  blue: Double(withHex & 0xff) / 255.0)
    }
    
    struct FlatColor {
        struct Blue {
            static let PictonBlue = Color(withHex: 0x99E3FF /* 0x5CADCF*/)
            static let Mariner = Color(withHex: 0x3585C5)
            static let CuriousBlue = Color(withHex: 0x4590B6)
            static let Denim = Color(withHex: 0x2F6CAD)
            static let Chambray = Color(withHex: 0x485675)
            static let BlueWhale = Color(withHex: 0x29334D)
        }

        struct Green {
            static let Fern = Color(withHex: 0x6ABB72)
            static let MountainMeadow = Color(withHex: 0x3ABB9D)
            static let ChateauGreen = Color(withHex: 0x4DA664)
            static let PersianGreen = Color(withHex: 0x2CA786)
        }
        
        struct Yellow {
            static let Energy = Color(withHex: 0xF2D46F)
            static let Turbo = Color(withHex: 0xF7C23E)
        }
        
        struct Orange {
            static let NeonCarrot = Color(withHex: 0xF79E3D)
            static let Sun = Color(withHex: 0xEE7841)
        }
    
        struct Gray {
            static let AlmondFrost = Color(withHex: 0xA28F85)
            static let WhiteSmoke = Color(withHex: 0xEFEFEF)
            static let Iron = Color(withHex: 0xD1D5D8)
            static let IronGray = Color(withHex: 0x75706B)
        }
    }
    
    static let tipBackgroundColor = Color(withHex: 0x99E3FF)
}
