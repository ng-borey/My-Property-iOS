//
//  PropertyListingResources.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 5/6/23.
//

import Foundation

enum PropertyListingResource {
    case fecthListing
}

extension PropertyListingResource: TargetResource {

    var baseURL: URL {
        guard let url = URL(string: Configure.baseUrl) else {
            fatalError("Invalid Base URL.")
        }
        return url
    }

    var method: HttpMethod {
        switch self {
            case .fecthListing:
                return .GET
        }
    }

//    var version: String {
//        return ""
//    }

//    var prefix: String? {
//        return "api"
//    }

    var authorizeType: AuthorizationType {
        switch self {
            case .fecthListing:
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
            case .fecthListing:
                return "/api/property/list"
        }
    }

    var params: [String : String]? {
        switch self {
            case .fecthListing:
                return nil
        }
    }

    var body: Data? {
        switch self {
            case .fecthListing:
                return nil
        }
    }

    var timeoutInterval: TimeInterval {
        return 60.0
    }

    var targetService: TargetService {
        return .zpoin
    }
}
