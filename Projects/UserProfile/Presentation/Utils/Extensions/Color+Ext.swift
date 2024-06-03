//
//  Color+Ext.swift
//  UserProfile
//
//  Created by Arvind on 03/06/24.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xff) / 255,
                  green: Double((hex >> 08) & 0xff) / 255,
                  blue: Double((hex >> 00) & 0xff) / 255,
                  opacity: alpha)
    }
    
    static func color(_ type: ColorType) -> Color {
        return Color(hex: type.code)
    }
}

enum ColorType {
    case black
    case white
    case dandelion
    
    var code: UInt {
        switch self {
        case .black: return 0x000000
        case .white: return 0xFFFFFF
        case .dandelion: return 0xFFD15B
        }
    }
}
