//
//  GEnum.swift
//  PasswordManager
//
//  Created by sanket on 06/08/25.
//

import SwiftUI

var appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
?? "Password Manager"

enum AppColor {
    static let themeBlack = Color("ThemeBlack")
    static let themeGrey = Color("ThemeGrey")
    static let themeGrey2 = Color("ThemeGrey2")
    static let themeGreyDivider = Color("ThemeGreyDivider")
    static let themeBackground = Color("ThemeBackground")
    static let themeBlue = Color("ThemeBlue")
    static let themeRed = Color("ThemeRed")
    static let themeBtnBlack = Color("ThemeBtnBlack")
}

enum AppFont: String {
    case sf_medium = "SFProDisplay-Medium"
    case sf_semiBold = "SFProDisplay-Semibold"
    case sf_bold = "SFProDisplay-Bold"
    case poppins_bold = "Poppins-Bold"
    case poppins_semibold = "Poppins-Semibold"
    case roboto_medium = "Roboto-Medium"

    func font(size: CGFloat) -> Font {
        return .custom(self.rawValue, size: size)
    }
}
