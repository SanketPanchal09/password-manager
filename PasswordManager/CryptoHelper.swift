//
//  CryptoHelper.swift
//  PasswordManager
//
//  Created by sanket on 06/08/25.
//
import Foundation
import CryptoKit

class CryptoHelper {
    
    static let shared = CryptoHelper()
    private init() {}

    private let keyTag = "com.PasswordManager.aesKey"

    private lazy var key: SymmetricKey = {
        if let storedData = loadKeyFromKeychain() {
            return SymmetricKey(data: storedData)
        } else {
            let newKey = SymmetricKey(size: .bits256)
            saveKeyToKeychain(newKey)
            return newKey
        }
    }()

    // MARK: - Encrypt
    func encrypt(_ string: String) -> Data? {
        let data = Data(string.utf8)
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined
        } catch {
            print("Encryption error:", error)
            return nil
        }
    }

    // MARK: - Decrypt
    func decrypt(_ data: Data) -> String? {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(decoding: decryptedData, as: UTF8.self)
        } catch {
            print("Decryption error:", error)
            return nil
        }
    }

    // MARK: - Keychain: Save Key
    private func saveKeyToKeychain(_ key: SymmetricKey) {
        let keyData = key.withUnsafeBytes { Data($0) }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyTag,
            kSecValueData as String: keyData,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)

        if status != errSecSuccess {
            print("Failed to save AES key to Keychain: \(status)")
        }
    }

    // MARK: - Keychain: Load Key
    private func loadKeyFromKeychain() -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keyTag,
            kSecReturnData as String: true
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecSuccess {
            return result as? Data
        } else {
            print("Key not found in Keychain: \(status)")
            return nil
        }
    }
}
