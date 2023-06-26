//
//  ColorUtils.swift
//  SkinPedia
//
//  Created by Rainer Regan on 22/06/23.
//

import Foundation
import SwiftUI

extension Color {
    static var cream: Color = Color(hex: CustomColor.cream)
    static var lightBrown: Color = Color(hex: CustomColor.lightBrown)
    static var mediumBrown: Color = Color(hex: CustomColor.mediumBrown)
    static var darkBrown: Color = Color(hex: CustomColor.darkBrown)
    static var customBlack: Color = Color(hex: CustomColor.black)
    static var customYellow: Color = Color(hex: CustomColor.yellow)
    static var customRed: Color = Color(hex: CustomColor.red)
    
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
    static var red: UInt = 0xDE4E45
}
