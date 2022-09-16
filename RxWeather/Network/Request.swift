//
//  Request.swift
//  RxWeather
//
//  Created by Дина Турман on 06.09.2022.
//

import Foundation


public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]
public typealias Body = [String: Any?]

typealias NetworkResult<T> = Swift.Result<T, NetworkError>

public protocol Request {
    associatedtype ResponseType where ResponseType: Decodable
    associatedtype NetworkErrorType = NetworkError
    
     var baseUrl: String { get }

     var path: String { get }

     var method: HTTPMethod { get }

     var headers: HTTPHeaders? { get }

     var query: Parameters? { get }

     var body: Body? { get }    
}

public extension Request {
     var method: HTTPMethod {
        .get
    }
    
     var headers: HTTPHeaders? {
        nil
    }
    
     var query: Parameters? {
        nil
    }
    
     var body: Body? {
        nil
    }
}
