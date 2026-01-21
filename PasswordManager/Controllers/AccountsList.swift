//
//  AccountsList.swift
//  PasswordManager
//
//  Created by sanket on 06/08/25.
//

import SwiftUI
import RealmSwift

struct AccountsList: View {

    // MARK: - State & Data
    @State private var isShowingAddAccount = false
    @State private var selectedAccount: AccountModel? = nil
//    @ObservedResults(AccountModel.self) var accounts
    @ObservedResults(AccountModel.self, sortDescriptor: SortDescriptor(keyPath: "createdAt", ascending: false)) var accounts


    // MARK: - Init
    init() {
        let config = Realm.Configuration.defaultConfiguration
        print("Realm file location: \(config.fileURL!.path)")
    }

    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                content
                floatingAddButton
            }
            .background(AppColor.themeBackground)
            .navigationBarHidden(true)
            .sheet(item: $selectedAccount) { account in
                AccountDetailSheet(account: account)
                    .presentationDetents([.height(380)])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(17)
            }
            .sheet(isPresented: $isShowingAddAccount) {
                AddAccountSheet()
                    .presentationDetents([.height(350)])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(17)
            }
        }
    }

    // MARK: - Main Content
    private var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // Header
            Text("Password Manager")
                .font(AppFont.sf_semiBold.font(size: 18))
                .foregroundColor(.black)
                .padding(.vertical, 15)
                .padding(.horizontal, 15)

            Divider()
                .background(Color.themeGreyDivider)

            ScrollView {
                VStack(spacing: 18) {
                    ForEach(accounts) { account in
                        accountRow(account)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 100)
            }
        }
    }

    // MARK: - Floating Add Button
    private var floatingAddButton: some View {
        Button(action: {
            isShowingAddAccount = true
        }) {
            Image("plus")
        }
        .padding(.trailing, 24)
        .padding(.bottom, 24)
    }

    // MARK: - Account Row View
    private func accountRow(_ account: AccountModel) -> some View {
        Button(action: {
            selectedAccount = account
        }) {
            HStack(spacing: 12) {
                Text(account.name)
                    .font(AppFont.sf_semiBold.font(size: 20))
                    .foregroundColor(AppColor.themeBlack)
                    .lineLimit(1)

                Text("*******")
                    .foregroundColor(AppColor.themeGrey)
                    .lineLimit(1)

                Spacer()
                Image("arrow_right")
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 21)
            .background(Color.white)
            .cornerRadius(999)
            .padding(.horizontal)
        }
    }
}

