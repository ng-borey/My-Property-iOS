//
//  AuthServices.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 8/6/23.
//

import Foundation

final class AuthServices: BaseService {

    public func onLogin(credential: Data, completion: ((Result<TokenModel, NetworkError>) -> Void)?) {
        let resource = MultiTarget<TokenModel>.init(AuthResource.login(credential))
        ws.request(resource: resource, completion: { result in
            switch result {
                case .success(let data):
                    completion?(.success(data))
                
                case .failure(let error):
                print("error \(error)")
                    completion?(.failure(error))
            }
        }, errorUnauthorize: true)
    }
}
