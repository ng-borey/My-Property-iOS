//
//  MultiTarget.swift
//  Z1
//
//  Created by DUCH Chamroeun on 14/6/21.
//  Copyright © 2021 Gaeasys. All rights reserved.
//

import Foundation

enum MultiTarget<T: Codable>: TargetResource {

    case target(TargetResource)

    init(_ target: TargetResource) {
        self = MultiTarget.target(target)
    }
    
    var baseURL: URL {
        return target.baseURL
    }
    
    var path: String {
        return target.path
    }
    
    var method: HttpMethod {
        return target.method
    }
    
//    var prefix: String? {
//        return target.prefix
//    }
    
    var body: Data? {
        return target.body
    }
    
//    var version: String {
//        return target.version
//    }
    
    var params: [String : String]? {
        return target.params
    }
    
    var authorizeType: AuthorizationType {
        return target.authorizeType
    }
    
    var header: [String : String] {
        return target.header
    }

    var timeoutInterval: TimeInterval {
        return 60.0
    }

    var target: TargetResource {
        switch self {
        case .target(let target): return target
        }
    }

    var targetService: TargetService {
        return .z1
    }
}


extension MultiTarget {
    
    var id: String {
        return "identifies" + self.baseURL.absoluteString + self.method.rawValue + self.path
    }
}
