//
//  TokenModel.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 8/6/23.
//

import Foundation

struct TokenModel: Codable {
    let tokenType: String
    let expiresIn: Int
    let accessToken, refreshToken: String
    let userID: Int
    let roles: [String]

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case userID = "user_id"
        case roles
    }
}
