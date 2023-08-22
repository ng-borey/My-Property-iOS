//
//  AutheResources.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 8/6/23.
//

import Foundation


enum AuthResource {
    case login(Data)
}

extension AuthResource: TargetResource {

    var baseURL: URL {
        guard let url = URL(string: Configure.z1Url) else {
            fatalError("Invalid Base URL.")
        }
        return url
    }

    var method: HttpMethod {
        switch self {
            case .login:
                return .POST
        }
    }

    var authorizeType: AuthorizationType {
        switch self {
            case .login:
                return .bearer
        }
    }

    var header: [String : String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
    }

    var path: String {
        switch self {
            case .login:
                return "signin-or-signup"
        }
    }

    var params: [String : String]? {
        switch self {
            case .login:
                return nil
        }
    }

    var body: Data? {
        switch self {
            case .login(let data):
                return data
        }
    }

    var timeoutInterval: TimeInterval {
        return 60.0
    }

    var targetService: TargetService {
        return .zpoin
    }
}
