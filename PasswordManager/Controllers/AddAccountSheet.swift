//
//  AddAccountSheet.swift
//  PasswordManager
//
//  Created by sanket on 06/08/25.
//

import SwiftUI
import RealmSwift

struct AddAccountSheet: View {
    
    // MARK: - Environment & State
    @Environment(\.dismiss) private var dismiss
    @State private var accountName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var showValidationAlert = false
    @State private var alertMessage = ""

    private let realmManager = RealmManager()
    var existingAccount: AccountModel?
    
    // MARK: - Init
    init(account: AccountModel? = nil) {
        self.existingAccount = account
        _accountName = State(initialValue: account?.name ?? "")
        _username = State(initialValue: account?.username ?? "")
        _password = State(initialValue: account?.password ?? "")
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 24) {

            formFields
                .padding(.horizontal, 30)
            
            Button(action: submitAccount) {
                Text(existingAccount == nil ? "Add New Account" : "Update Account")
                    .font(AppFont.poppins_bold.font(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(AppColor.themeBtnBlack)
                    .cornerRadius(100)
            }
            .padding(.horizontal, 25)
        }
        .alert(appName, isPresented: $showValidationAlert, actions: {
            Button("Okay", role: .cancel) { }
        }, message: {
            Text(alertMessage)
        })
    }

    
    // MARK: - Form Fields View
    private var formFields: some View {
        VStack(spacing: 16) {
            TextField("Account Name", text: $accountName)
                .inputStyle()
            
            TextField("Username/ Email", text: $username)
                .inputStyle()
                .onChange(of: username) { newValue in
                    username = newValue.replacingOccurrences(of: " ", with: "")
                }
            
            SecureField("Password", text: $password)
                .inputStyle()
                .onChange(of: password) { newValue in
                    password = newValue.replacingOccurrences(of: " ", with: "")
                }
        }
    }
    
    // MARK: - Submit Account
    private func submitAccount() {
        guard validateFields() else { return }

        if let accountToUpdate = existingAccount?.thaw() {
            realmManager.updateAccount(account: accountToUpdate,
                                       name: accountName,
                                       username: username,
                                       password: password) {
                dismiss()
            }
        } else {
            realmManager.addAccount(name: accountName,
                                    username: username,
                                    password: password) {
                dismiss()
            }
        }
    }

    // MARK: - Validation
    private func validateFields() -> Bool {
        if accountName.isEmpty {
            return showAlert("Please enter account name")
        }
        if username.isEmpty {
            return showAlert("Please enter username or email")
        }
        if password.isEmpty {
            return showAlert("Please enter password")
        }
        return true
    }

    // MARK: - Alert Trigger
    @discardableResult
    private func showAlert(_ message: String) -> Bool {
        alertMessage = message
        showValidationAlert = true
        return false
    }
}
