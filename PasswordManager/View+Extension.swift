//
//  View + Extension.swift
//  PasswordManager
//
//  Created by sanket on 06/08/25.
//

import SwiftUI

// MARK: - Theme TextField Style
extension View {
    func inputStyle() -> some View {
        self
            .padding()
            .font(AppFont.roboto_medium.font(size: 13))
            .foregroundColor(AppColor.themeBlack)
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(AppColor.themeGrey2, lineWidth: 0.6))
    }
}
