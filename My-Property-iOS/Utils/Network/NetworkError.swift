//
//  NetworkError.swift
//  Z1
//
//  Created by DUCH Chamroeun on 24/6/21.
//  Copyright © 2021 Gaeasys. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    /// - The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.
    case gatewayTimeout
    /// - serviceUnavailable: The server is currently unavailable (because it is overloaded or down for maintenance). Generally, this is a temporary state.
    case serviceUnavailable(service: TargetService)
    /// - The server was acting as a gateway or proxy and received an invalid response from the upstream server.
    case badGateway
    /// - happen when server got internal error
    case internalServerError
    /// - happen when Validation Error showing message to describe validation rule
    case unprocessableEntity(validate: [String: Any])
    /// - happen when data or photo or file submit is bigger than server configuration
    case payloadTooLarge
    /// - happen when send wrong HTTP method
    case methodNotAllowed
    /// - happen when page not found or record not found
    case notFound
    /// - happen when user has no permission to access
    case forbidden
    /// - happen when fail login
    case unauthorized
    /// - General error or use in custom error message
    case badRequest
    /// - When server respond with wrong data model
    case decodingError
    /// - No Internet Connection
    case unavailable
    /// - When client side is not recognized error codes
    case undefined(statusCode: Int)
    /// - Default general error message when not reach to server on first start up (store on client side)
    case generalError
    /// - HTTPVersionNotSupported: The server does not support the HTTP protocol version used in the request.
    case versionNotSupported
    /// - Custom the error with message
    case custom(String)
    
    var msg: String {
        switch self {
            case .gatewayTimeout:
                return "LangKey.g_error_msg_504.text"
            case .serviceUnavailable:
                return "LangKey.generalErrorMsg503.text"
            case .badGateway:
                return "LangKey.g_error_msg_502.text"
            case .internalServerError:
                return "LangKey.g_error_msg_500.text"
            case .unprocessableEntity:
                return "LangKey.g_error_msg_422.text"
            case .payloadTooLarge:
                return "LangKey.g_error_msg_413.text"
            case .methodNotAllowed:
                return "LangKey.g_error_msg_405.text"
            case .notFound:
                return "LangKey.g_error_msg_404.text"
            case .forbidden:
                return "LangKey.g_error_msg_403.text"
            case .unauthorized:
                return "LangKey.g_error_msg_401.text"
            case .badRequest:
                return "LangKey.g_error_msg_400.text"
            case .decodingError:
                return "LangKey.g_error_msg_mapping_model.text"
            case .unavailable:
                return "LangKey.g_error_msg_internet.text"
            case .undefined:
                return "LangKey.g_error_msg_undifine.text"
            case .generalError:
                return "LangKey.g_error_msg_general.text"
            case .versionNotSupported:
                return "LangKey.generalErrorMsg505.text"
            case .custom(let msg):
                return msg
        }
    }
    
    var errorCode: String? {
        switch self {
            case .gatewayTimeout:
                return "[504] [Gateway Timeout]".uppercased()
            case .serviceUnavailable:
                return "[503] [Service Temporarily Unavailable]".uppercased()
            case .badGateway:
                return "[502] [Bad Gateway]".uppercased()
            case .internalServerError:
                return "[500] [Internal Server Error]".uppercased()
            case .unprocessableEntity:
                return "[422] [Unprocessable Entity (WebDAV)]".uppercased()
            case .payloadTooLarge:
                return "[413] [Request Entity Too Large]".uppercased()
            case .methodNotAllowed:
                return "[405] [Method Not Allowed]".uppercased()
            case .notFound:
                return "[404] [Not Found]".uppercased()
            case .forbidden:
                return "[403] [Forbidden]".uppercased()
            case .unauthorized:
                return "[401] [Unauthorized]".uppercased()
            case .badRequest:
                return "[400] [Bad Request]".uppercased()
            case .versionNotSupported:
                return "[505] [HTTP Version Not Supported]".uppercased()
            case .decodingError, .generalError, .unavailable:
                return nil
            case .undefined(let statusCode):
                return "[\(statusCode)]"
            case .custom:
                return nil
        }
    }
    
    var code: Int {
        switch self {
            case .versionNotSupported:
                return 505
            case .gatewayTimeout:
                return 504
            case .serviceUnavailable:
                return 503
            case .badGateway:
                return 502
            case .internalServerError:
                return 500
            case .unprocessableEntity:
                return 422
            case .payloadTooLarge:
                return 413
            case .methodNotAllowed:
                return 405
            case .notFound:
                return 404
            case .forbidden:
                return 403
            case .unauthorized:
                return 401
            case .badRequest:
                return 400
            case .decodingError:
                return 600 // wrong mapping model
            case .unavailable:
                return 601 // code no internet
            case .undefined(let statusCode):
                return statusCode
            case .generalError, .custom:
                return 1000 // unknown error
        }
    }
}
