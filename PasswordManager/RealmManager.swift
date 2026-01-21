//
//  RealmManager.swift
//  PasswordManager
//
//  Created by sanket on 06/08/25.
//

import Foundation
import RealmSwift

class RealmManager {
    
    private let realm: Realm
    
    init() {
        do {
            realm = try Realm()
            
        } catch {
            fatalError("Error initializing Realm: \(error)")
        }
    }
    
    func addAccount(name: String, username: String, password: String, completion: (() -> Void)? = nil) {
        let newAccount = AccountModel()
        newAccount.name = name
        newAccount.username = username
        newAccount.password = password
        do {
            try realm.write {
                realm.add(newAccount)
                completion?()
            }
        } catch {
            print("Failed to save account: \(error)")
        }
    }
    
    func deleteAccount(_ account: AccountModel, completion: (() -> Void)? = nil) {
        guard let thawedAccount = account.thaw(),
              let realm = thawedAccount.realm else {
            print("Could not thaw account or get Realm")
            return
        }
        
        do {
            try realm.write {
                realm.delete(thawedAccount)
            }
            completion?()
        } catch {
            print("Failed to delete account: \(error)")
        }
    }
    
    func updateAccount(account: AccountModel, name: String, username: String, password: String, completion: (() -> Void)? = nil) {
        guard let realm = account.realm else {
            print("Realm not found for account")
            return
        }
        do {
            try realm.write {
                account.name = name
                account.username = username
                account.password = password
                completion?()
            }
        } catch {
            print("Update Error: \(error.localizedDescription)")
        }
    }
    
}
