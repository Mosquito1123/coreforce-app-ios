//
//  TokenResponse.swift
//  hfpower
//
//  Created by EDY on 2024/6/5.
//

import Foundation
import KakaJSON
// TokenResponse Model
struct TokenResponse: Convertible {
    var accessToken: String?
    var accessTokenExpiration: String?
    var refreshToken: String?
    var refreshTokenExpiration: String?
}

