//
//  BaseService.swift
//  Z1
//
//  Created by DUCH Chamroeun on 3/2/20.
//  Copyright © 2020 Gaeasys. All rights reserved.
//

import Foundation

protocol ServiceDelegate: AnyObject {
    func onSuccess<T: Codable>(ws: BaseService, with data: T)
    func onFail(ws: BaseService, with error: NetworkError)
}

class BaseService {
    let ws = WSManager.share
    var delegate: ServiceDelegate?
}
