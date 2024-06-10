//
//  Font+Ext.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI

enum AvenirNext: String {
    case bold = "Bold"
    case boldItalic = "BoldItalic"
    case demiBold = "DemiBold"
    case demiBoldItalic = "DemiBoldItalic"
    case heavy = "Heavy"
    case heavyItalic = "HeavyItalic"
    case italic = "Italic"
    case medium = "Medium"
    case mediumItalic = "MediumItalic"
    case regular = "Regular"
    case ultraLight = "UltraLight"
    case ultraLightItalic = "UltraLightItalic"
    
    func of(size: CGFloat) -> Font {
        return Font.custom("AvenirNext-\(self.rawValue)", size: size)
     }
}

extension Font {
    
    static let medium11 = AvenirNext.medium.of(size: 11)
    static let medium12 = AvenirNext.medium.of(size: 12)
    static let medium13 = AvenirNext.medium.of(size: 13)
    static let medium14 = AvenirNext.medium.of(size: 14)
    static let medium15 = AvenirNext.medium.of(size: 15)
    
    static let bold11 = AvenirNext.bold.of(size: 11)
    static let bold12 = AvenirNext.bold.of(size: 12)
    static let bold13 = AvenirNext.bold.of(size: 13)
    static let bold14 = AvenirNext.bold.of(size: 14)
    static let bold15 = AvenirNext.bold.of(size: 15)
    
    static let regular11 = AvenirNext.regular.of(size: 11)
    static let regular12 = AvenirNext.regular.of(size: 12)
    static let regular13 = AvenirNext.regular.of(size: 13)
    static let regular14 = AvenirNext.regular.of(size: 14)
    static let regular15 = AvenirNext.regular.of(size: 15)
}
