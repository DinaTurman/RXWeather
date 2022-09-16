//
//  NetworkProviderRequest.swift
//  RxWeather
//
//  Created by Дина Турман on 06.09.2022.
//

import Foundation
import RxSwift


final class NetworkProviderRequest<RequestType: Request> {
    private var request: RequestType
    
    init(request: RequestType) {
        self.request = request
    }
    
    var method: HTTPMethod {
        request.method
    }
    
    var urlString: String {
        let baseUrl = request.baseUrl
        let path = request.path
        
        return baseUrl + path
    }
    
    var headers: HTTPHeaders? {
        request.headers
    }
    
    var query: Parameters? {
        request.query
    }
    
    var body: Body? {
        request.body
    }
    
    var httpBody: Data? {
       guard let body = body, !body.isEmpty else { return nil }
       return try? JSONSerialization.data(withJSONObject: body, options: [])
   }
    
    func getRequest() throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw NetworkError.missingURL
        }
        //Создает и инициализирует URL-запрос с заданным URL, политикой кэширования и интервалом тайм-аута.
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        
        addHeaders(to: &request)
        try addParameters(to: &request)
        
        return request
    }

    private func addParameters(to request: inout URLRequest) -> Bool {
        guard let url = request.url else { return false }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = [URLQueryItem]()
            if let query = query {
                for (key, value) in query {
                    let queryItem = URLQueryItem(name: key, value: "\(value)")
                    urlComponents.queryItems?.append(queryItem)
                }
            }
            
            request.url = urlComponents.url
        }
        
        return true
    }
    
    private func addHeaders(to request: inout URLRequest) {
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
    }

}
