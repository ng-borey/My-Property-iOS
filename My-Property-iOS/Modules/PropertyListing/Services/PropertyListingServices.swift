//
//  PropertyListingServices.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 5/6/23.
//

import Foundation

final class PropertyListingServices: BaseService {

    public func fetchPropertyListing(completion: ((Result<ListingModel, NetworkError>) -> Void)?) {
        let resource = MultiTarget<ListingModel>.init(PropertyListingResource.fecthListing)
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
