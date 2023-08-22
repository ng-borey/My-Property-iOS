//
//  WSMananger.swift
//  iOS Structure
//
//  Created by DUCH Chamroeun on 1/16/20.
//  Copyright © 2020 DUCH Chamroeurn. All rights reserved.
//

import Foundation

struct NoContent: Codable {
    init() {}
}

final class WSManager: NSObject {
    
    public static var share = WSManager()
    
    private override init() {
        super.init()
        onCompleteRequest = { [weak self] (taskID) in
            if let taskIdentifier = taskID {
                self?.removeFinishedTask(by: taskIdentifier)
            }
        }
    }
    
    private var dataTask: URLSessionDataTask!
    
    private var allTasks: [DataTask] = []
    
    public func cancelAllTasks() {
        allTasks.forEach({$0.dataTask.cancel()})
        allTasks.removeAll()
    }
    
    public func cancelTask(taskID: String) {
        if let dataTask = allTasks.first(where: { $0.taskID == taskID }) {
            dataTask.dataTask.cancel()
            allTasks.removeAll(where: { $0.taskID == taskID })
        }
    }
    
    public func cancelAllTasks(except taskID: String) {
        allTasks.filter({$0.taskID != taskID}).forEach({$0.dataTask.cancel()})
        allTasks.removeAll()
    }
    
    private func removeFinishedTask(by taskID: String) {
        for (index, item) in allTasks.enumerated() {
            if item.taskID == taskID {
                allTasks.remove(at: index)
                break
            }
        }
    }
    
    private var onCompleteRequest: ((String?)->()) = { (_) in }
    
    public func request<T>(resource: MultiTarget<T>, completion: @escaping (Result<T, NetworkError>)->(), errorUnauthorize: Bool = false) {
        buildURLRequest(resource.target) { (request) in
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            self.dataTask = session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    
                    if error?.localizedDescription.lowercased() == "cancelled".lowercased() {
                        print("task cancelled")
                        return
                    }
                    
                    if error?.localizedDescription == "The Internet connection appears to be offline." {
                        DispatchQueue.main.async {
                            self.onCompleteRequest(resource.id)
                            completion(.failure(.unavailable))
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self.onCompleteRequest(resource.id)
                    }
                    return
                }
                if let httpResponse = response as? HTTPURLResponse{
                    let statusCode = httpResponse.statusCode
                    if let httpStatusCode = HTTPStatusCode.init(rawValue: statusCode) {
                        switch httpStatusCode {
                            //MARK: - SUCCESS CODE
                        case .ok, .accepted, .created:
                            do {
                                let result = try JSONDecoder().decode(T.self, from: data)
                                DispatchQueue.main.async {
                                    self.onCompleteRequest(resource.id)
                                    completion(.success(result))
                                }
                            } catch let error {
                                debugPrint("===DecodeError==== CodingPath:", String(describing: T.self))
                                debugPrint("===DecodeError==== CodingPath:", error)
                                DispatchQueue.main.async {
                                    self.onCompleteRequest(resource.id)
                                    completion(.failure(.decodingError))
                                }
                            }
                        case .noContent:
                            let noContent = NoContent()
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.success(noContent as! T))
                            }
                        case .gatewayTimeout:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.gatewayTimeout))
                            }
                        case .serviceUnavailable:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.serviceUnavailable(service: resource.target.targetService)))
                            }
                        case .badGateway:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.badGateway))
                            }
                        case .internalServerError:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.internalServerError))
                            }
                        case .unprocessableEntity:
                            let responseData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.unprocessableEntity(validate: responseData ?? [:])))
                            }
                        case .payloadTooLarge:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.payloadTooLarge))
                            }
                            break
                        case .methodNotAllowed:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.methodNotAllowed))
                            }
                            break
                        case .notFound:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.notFound))
                            }
                            break
                        case .forbidden:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.forbidden))
                            }
                            break
                        case .unauthorized:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.unauthorized))
                            }
                        case .badRequest:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.badRequest))
                            }
                            break
                        case .HTTPVersionNotSupported:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.versionNotSupported))
                            }
                            break
                        default:
                            DispatchQueue.main.async {
                                self.onCompleteRequest(resource.id)
                                completion(.failure(.undefined(statusCode: statusCode)))
                            }
                            break
                        }
                    }
                }
            }
            
            self.allTasks.append(DataTask(taskID: resource.id, dataTask: self.dataTask))
            self.dataTask.resume()
        }
    }
    
    private func buildURLRequest(_ resource: TargetResource, completion: @escaping (URLRequest) ->Void) {
        var url = resource.baseURL
//        if let prefix = resource.prefix {
//            url.appendPathComponent(prefix)
//        }
//        url.appendPathComponent(resource.version)
        url.appendPathComponent(resource.path)
        
        if let params = resource.params,   var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            
            var queryItems = [URLQueryItem]()
            for (key, value) in params {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            
            urlComponents.queryItems = queryItems
            if let fullURL = urlComponents.url {
                url = fullURL
            }
        }
        
        print("URL Request = ", url)
        var request = URLRequest(url: url, timeoutInterval: resource.timeoutInterval)
        request.httpMethod = resource.method.rawValue
        request.httpBody = resource.body
        for (key, value) in resource.header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        let use = "MjNmYzM4ZjItYmI2MC00ZjMxLThjYzEtZjIyMGZkYTY2ZGJh"
//        print(use.token.values)
        switch resource.authorizeType {
        case .none:
            completion(request)
        case .bearer:
            request.addValue("Bearer \(use)", forHTTPHeaderField: "Authorization")
            completion(request)
        case .tempBearer:
            request.addValue("Bearer \(use)", forHTTPHeaderField: "Authorization")
            completion(request)
        case .optionalBearer:
            request.addValue("Bearer \(use)", forHTTPHeaderField: "Authorization")
            completion(request)
        }
    }
}

fileprivate struct DataTask {
    var taskID: String
    var dataTask: URLSessionDataTask
}

extension WSManager {
    
    ///////////////////////////////////////////////////////////////////////////////////////
    // MARK: Download File
    ///////////////////////////////////////////////////////////////////////////////////////
    
    class func download(url: URL, to localUrl: URL, completion: @escaping (Bool) -> ()) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            
            // Success ?
            if let tempLocalUrl = tempLocalUrl, error == nil {
                do {
                    if FileManager.default.fileExists(atPath: localUrl.path) {
                        try FileManager.default.removeItem(at: localUrl)
                    }
                    try FileManager.default.copyItem(at: tempLocalUrl, to: localUrl)
                    
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } catch (let writeError) {
                    print("ERROR writing file \(localUrl) -> \(writeError)")
                    
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
                
                
            } else { // Error?
                print("ERROR Downloading: \(url) -> \(error?.localizedDescription ?? "")")
                
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
        task.resume()
    }
}
