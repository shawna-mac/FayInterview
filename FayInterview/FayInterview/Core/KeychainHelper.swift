//
//  KeychainHelper.swift
//  FayInterview
//
//  Created by Shawna MacNabb on 6/13/25.
//

import Foundation
import Security

class KeychainHelper {

    init() {}

    /// Save a value to Keychain for a given key
    static func set(_ value: String, forKey key: String) {
        guard let data = value.data(using: .utf8) else { return }

        delete(forKey: key)

        let query: [String: Any] = [
            kSecClass as String:             kSecClassGenericPassword,
            kSecAttrAccount as String:       key,
            kSecValueData as String:         data,
            kSecAttrAccessible as String:    kSecAttrAccessibleWhenUnlocked
        ]

        SecItemAdd(query as CFDictionary, nil)
    }

    /// Retrieve a value from Keychain for a given key
    static func get(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String:             kSecClassGenericPassword,
            kSecAttrAccount as String:       key,
            kSecReturnData as String:        true,
            kSecMatchLimit as String:        kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess,
              let data = result as? Data,
              let string = String(data: data, encoding: .utf8) else {
            return nil
        }

        return string
    }

    /// Delete a value from Keychain for a given key
    static func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String:             kSecClassGenericPassword,
            kSecAttrAccount as String:       key
        ]

        SecItemDelete(query as CFDictionary)
    }
}
