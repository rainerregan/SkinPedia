//
//  ColorUtils.swift
//  SkinPedia
//
//  Created by Rainer Regan on 22/06/23.
//

import Foundation
import SwiftUI


extension Color {
    static public var cream: Color = Color(hex: CustomColor.cream)
    static var customBrown : Color = Color(hex: CustomColor.brown)
    static var lightBrown: Color = Color(hex: CustomColor.lightBrown)
    static var mediumBrown: Color = Color(hex: CustomColor.mediumBrown)
    static var darkBrown: Color = Color(hex: CustomColor.darkBrown)
    static var customBlack: Color = Color(hex: CustomColor.black)
    static var customYellow: Color = Color(hex: CustomColor.yellow)
    static var customRed: Color = Color(hex: CustomColor.red)
    static var redDanger: Color = Color(hex: CustomColor.redDanger)
    static var customLightGray : Color = Color(hex: CustomColor.lightGray)
    static var customDarkGray : Color = Color(hex: CustomColor.darkGray)
    static var customMediumGray : Color = Color(hex: CustomColor.mediumGray)
    static var lightestBrown : Color = Color(hex: CustomColor.ligthestBrown)
    static var textGray : Color = Color(hex: CustomColor.textGray)
    static var lightestYellow : Color = Color(hex : CustomColor.lightestYellow)
    
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static func getColorFromAllergentsCount(allergentsCount: Int) -> Color {
        if(allergentsCount == 0){
            return Color.green
        } else if allergentsCount >= 1 && allergentsCount < 4{
            return Color.customYellow
        } else {
            return Color.red
        }
    }
}

struct CustomColor {
    static var cream: UInt = 0xF5ECDB
    static var lightBrown: UInt = 0xDED8CD
    static var mediumBrown: UInt = 0xCDBEA5
    static var darkBrown: UInt = 0x44413C
    static var black: UInt = 0x272727
    static var yellow: UInt = 0xFFC107
    static var red: UInt = 0x8C1818
    static var brown: UInt = 0x6F5240
    static var redDanger : UInt = 0xBA0A00
    static var lightGray : UInt = 0xF5F8F9
    static var darkGray : UInt = 0x9A9A9A
    static var mediumGray : UInt = 0xCACACA
    static var ligthestBrown : UInt = 0xF5ECDB
    static var textGray : UInt = 0x828282
    static var lightestYellow : UInt = 0xF5ECDB
}
