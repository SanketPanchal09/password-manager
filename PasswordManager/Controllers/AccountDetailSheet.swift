//
//  AccountDetailSheet.swift
//  PasswordManager
//
//  Created by sanket on 06/08/25.
//

import SwiftUI
import RealmSwift

struct AccountDetailSheet: View {
    
    // MARK: - Properties
    @ObservedRealmObject var account: AccountModel
    @Environment(\.dismiss) private var dismiss
    @State private var isPasswordHidden = true
    @State private var showDeleteConfirmation = false
    @State private var showEditView = false

    private let realmManager = RealmManager()
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            
            Text("Account Details")
                .font(AppFont.sf_bold.font(size: 19))
                .foregroundColor(AppColor.themeBlue)
            
            VStack(alignment: .leading, spacing: 24) {
                sectionRow(title: "Account Type", value: account.name)
                sectionRow(title: "Username/ Email", value: account.username)
                passwordSection
            }
            
            actionButtons
            Spacer()
        }
        .padding()
        .alert(appName, isPresented: $showDeleteConfirmation, actions: {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                realmManager.deleteAccount(account) {
                    dismiss()
                }
            }
        }, message: {
            Text("Are you sure you want to delete this account?")
        })
    }

    // MARK: - Section View
    private func sectionRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(AppFont.roboto_medium.font(size: 11))
                .foregroundColor(AppColor.themeGrey2)
            Text(value)
                .font(AppFont.poppins_semibold.font(size: 16))
                .foregroundColor(AppColor.themeBlack)
        }
    }

    // MARK: - Password Section
    private var passwordSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Password")
                .font(AppFont.roboto_medium.font(size: 11))
                .foregroundColor(AppColor.themeGrey2)
            
            HStack {
                Text(isPasswordHidden ? String(repeating: "*", count: account.password.count) : account.password)
                    .font(AppFont.poppins_semibold.font(size: 16))
                    .foregroundColor(AppColor.themeBlack)
                
                Spacer()
                
                Button(action: {
                    isPasswordHidden.toggle()
                }) {
                    Image(systemName: isPasswordHidden ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
        }
    }

    // MARK: - Action Buttons
    private var actionButtons: some View {
        HStack(spacing: 16) {
            
            // Edit Button
            actionButton(title: "Edit", bgColor: AppColor.themeBlack) {
                showEditView = true
            }
            .sheet(isPresented: $showEditView) {
                AddAccountSheet(account: account)
                    .presentationDetents([.height(350)])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(17)
            }
            
            // Delete Button
            actionButton(title: "Delete", bgColor: AppColor.themeRed) {
                showDeleteConfirmation = true
            }
        }
    }

    private func actionButton(title: String, bgColor: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.poppins_bold.font(size: 16))
                .frame(maxWidth: .infinity)
                .padding()
                .background(bgColor)
                .foregroundColor(.white)
                .cornerRadius(50)
        }
    }
}
