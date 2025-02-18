//
//  md5Extension.swift
//  TakeHomeProjectRecipes
//
//  Created by Fredy on 2/17/25.
//

import Foundation
import CryptoKit

/// A extenson to help with disk caching.
extension String {
    /// Computes the MD5 hash of the string.
    /// - Returns: A hexadecimal string representing the MD5 hash.
    var md5: String {
        let digest = Insecure.MD5.hash(data: Data(self.utf8))
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
