//
//  Endpoint.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
}

final class Endpoint<R>: ResponseRequestable {
    
    typealias Response = R
    
    var path: String
    var method: HTTPMethodType
    var queryParameters: [String : Any]
    var queryParametersEncodable: Encodable?
    var responseDecoder: ResponseDecoder
    
    init(path: String,
         method: HTTPMethodType,
         queryParameters: [String: Any] = [:],
         queryParametersEncodable: Encodable? = nil,
         responseDecoder: ResponseDecoder = JsonResponseDecoder()) {
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.queryParametersEncodable = queryParametersEncodable
        self.responseDecoder = responseDecoder
    }
}

protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var queryParameters: [String: Any] { get }
    var queryParametersEncodable: Encodable? { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

protocol ResponseRequestable: Requestable {
    associatedtype Response
    var responseDecoder: ResponseDecoder { get }
}

enum RequestGenerationError: Error {
    case components
}

extension Requestable {
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest {
        
        let url = networkConfig.baseURL.appendingPathComponent(path).absoluteString
        guard var urlComponents = URLComponents(string: url) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()
        
        if let queryParameters = try queryParametersEncodable?.toDictionary() {
            queryParameters.forEach {
                urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
            }
        }
        
        networkConfig.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
