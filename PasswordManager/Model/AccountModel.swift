//
//  Account.swift
//  PasswordManager
//
//  Created by sanket on 06/08/25.
//

import SwiftUI
import RealmSwift

class AccountModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var username: String = ""
    @Persisted var encryptedPassword: Data = Data()
    @Persisted var createdAt: Date = Date()  // <-- Add this

    var password: String {
        get {
            CryptoHelper.shared.decrypt(encryptedPassword) ?? ""
        }
        set {
            encryptedPassword = CryptoHelper.shared.encrypt(newValue) ?? Data()
        }
    }

}
